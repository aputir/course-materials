// Shared English workshop reflection; see docs/brand/workshop-reflection-editorial.md.
// All typography, direction, and layout belong to theme.typ.
#let workshop-reflection = (
  image: "../../resources/assets/illustrations/workshop-01-shared-light-print.png",
  quote: "AI knows as much as you know.",
  story: [
    Two friends imagine a small fleet sailing across a white canvas. Both ask AI to create it in p5.js. One describes the scene; the other has animated objects before. They also specify how ships are drawn, how movement is updated, and what happens at the canvas edges.

    That experience turns a visual idea into a brief they can evaluate. Does the motion stay consistent? Can one ship's appearance change without rewriting its movement? Knowledge shapes both the request and the questions used to check the result. Like the shared lantern, AI illuminates possibilities; understanding helps direct the light and judge what it reveals.
  ],
  naive-label: [The first prompt],
  refined-label: [The same prompt, with context],
  naive: [Create ships and animate them around a canvas in p5.js.],
  refinement: [Build a complete sketch for the p5.js Web Editor: an 800 × 500 white canvas with five black-outline ships made from simple shapes. Use an array of `Ship` objects storing position, velocity, and size, with `display()`, `update()`, and `wrap()` methods. Initialize them in `setup()`; clear the background, update, and redraw in `draw()`. Express speed in pixels per second and scale movement by `deltaTime / 1000`. Wrap ships to the opposite edge only after their entire shape leaves the canvas. Use code comments to explain these choices and how to change ship count and speed.],
  output-instruction: [Your output must be only a p5.js codeblock.],
  takeaway: [The refinement makes visual choices, data, methods, and movement rules explicit. Understanding these decisions helps you guide the AI and evaluate its code.],
  invitation: [Try both prompts with the same AI and run the sketches. Compare the movement, edge behavior, and ease of changing the ships. Share your experience with your classmates, including one improvement you would make to the prompt.],
)
