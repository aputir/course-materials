#!/usr/bin/env swift
import Foundation
import Quartz
import CoreGraphics

guard CommandLine.arguments.count >= 2 else {
    fputs("Usage: swift scripts/compress-pdf.swift <input.pdf> [output.pdf]\n", stderr)
    exit(1)
}

let inputPath = (CommandLine.arguments[1] as NSString).standardizingPath
let outputPath = CommandLine.arguments.count >= 3 ? (CommandLine.arguments[2] as NSString).standardizingPath : inputPath

let inUrl = URL(fileURLWithPath: inputPath)
guard let pdfDoc = CGPDFDocument(inUrl as CFURL) else {
    fputs("Error: Could not read input PDF: \(inputPath)\n", stderr)
    exit(1)
}

let pageCount = pdfDoc.numberOfPages
guard pageCount > 0, let firstPage = pdfDoc.page(at: 1) else {
    fputs("Error: PDF has no pages\n", stderr)
    exit(1)
}

var mediaBox = firstPage.getBoxRect(.mediaBox)

// Preserve PDF metadata
var auxInfo: [CFString: Any] = [:]
if let info = pdfDoc.info {
    var titleVal: CGPDFStringRef?
    if CGPDFDictionaryGetString(info, "Title", &titleVal), let s = titleVal, let str = CGPDFStringCopyTextString(s) {
        auxInfo[kCGPDFContextTitle] = str as String
    }
    var authorVal: CGPDFStringRef?
    if CGPDFDictionaryGetString(info, "Author", &authorVal), let s = authorVal, let str = CGPDFStringCopyTextString(s) {
        auxInfo[kCGPDFContextAuthor] = str as String
    }
    var creatorVal: CGPDFStringRef?
    if CGPDFDictionaryGetString(info, "Creator", &creatorVal), let s = creatorVal, let str = CGPDFStringCopyTextString(s) {
        auxInfo[kCGPDFContextCreator] = str as String
    }
}

if auxInfo[kCGPDFContextTitle] == nil {
    auxInfo[kCGPDFContextTitle] = "از ماده تا هوش مصنوعی"
}
if auxInfo[kCGPDFContextAuthor] == nil {
    auxInfo[kCGPDFContextAuthor] = "دانشگاه تهران — برنامه‌سازی پیشرفته"
}
if auxInfo[kCGPDFContextCreator] == nil {
    auxInfo[kCGPDFContextCreator] = "Typst 0.15.1"
}

let fileManager = FileManager.default
let origSize = (try? fileManager.attributesOfItem(atPath: inputPath)[.size] as? Int64) ?? 0

let tempOutputUrl = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(UUID().uuidString + ".pdf")

guard let consumer = CGDataConsumer(url: tempOutputUrl as CFURL),
      let context = CGContext(consumer: consumer, mediaBox: &mediaBox, auxInfo as CFDictionary) else {
    fputs("Error: Failed to create PDF context\n", stderr)
    exit(1)
}

let filterURL = URL(fileURLWithPath: "/System/Library/Filters/Reduce File Size.qfilter")
guard let filter = QuartzFilter(url: filterURL) else {
    fputs("Error: Failed to load Quartz filter: \(filterURL.path)\n", stderr)
    exit(1)
}

filter.apply(to: context)

for i in 1...pageCount {
    if let page = pdfDoc.page(at: i) {
        var pageRect = page.getBoxRect(.mediaBox)
        context.beginPage(mediaBox: &pageRect)
        context.drawPDFPage(page)
        context.endPage()
    }
}

context.closePDF()

let outUrl = URL(fileURLWithPath: outputPath)
if fileManager.fileExists(atPath: outUrl.path) {
    try fileManager.removeItem(at: outUrl)
}
try fileManager.moveItem(at: tempOutputUrl, to: outUrl)

let newSize = (try? fileManager.attributesOfItem(atPath: outputPath)[.size] as? Int64) ?? 0

let origMB = Double(origSize) / 1024.0 / 1024.0
let newMB = Double(newSize) / 1024.0 / 1024.0
let reduction = (1.0 - (Double(newSize) / Double(max(origSize, 1)))) * 100.0

print(String(format: "Successfully compressed %d pages: %.1f MiB -> %.1f MiB (%.1f%% reduction)", pageCount, origMB, newMB, reduction))
