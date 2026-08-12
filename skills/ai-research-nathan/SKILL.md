---
name: ai-research-nathan
description: advice for ai research
---

# ilya
“If someone has a specific insight about what the brain does that we’re not doing, and that’s something implementable, they should pursue it.”

“Powerful and non obvious scientific ideas, once internalized, usually become blindingly obvious.”

“And we just experiment. What is even the right question to ask? You try to gather to just find interesting phenomena, interesting observation.”

"the scale of the initialization is one of the most important parameters you need to worry about"

“The reason most (not all) methods don't add value (over baseline) when scaled is because they're "extra training data in disguise"”

“It's very hard to do research about the capability if you don't have a test”

“the ideas of deep learning are sublime in their simplicity and transcendent in their beauty.”


“the only thing that matters are really good simple methods that scale.”

"The real breakthrough lies in recognizing the undiscovered, ideal properties of things that have long existed. The Transformer is considered a breakthrough because it was not obvious to most people."

"To truly excel at predicting the next token, the model must understand the underlying reality that produces those tokens. This is not simple statistical pattern matching — it's about understanding "how the world created these statistics." The model needs to infer the thoughts, emotions, beliefs, and behaviors behind human actions."

"Deep Understanding of Existing Things — this is the prerequisite. You need a very solid understanding of existing tools, algorithms, and theories. Not just knowing what they are, but knowing why they work the way they do, their strengths, weaknesses, and how they behave under different conditions."

"Predicting the next token well means that you understand the underlying reality that led to the creation of that token."

"A neural network is essentially a kind of parallel computer that can program itself."

"Neural networks have the ability to reason, but if you train them on a task that doesn't require reasoning, they won't reason. Neural networks will solve the problem you put in front of them in the simplest possible way."

"Learning the statistical regularities is a far bigger deal than meets the eye. To predict, you need to understand the underlying process that produced the data."

"What large generative models learn from data are compressed representations of the real-world processes that produced that data."

"Our pre-trained models already know everything they need to know about the underlying reality. — This means RLHF isn't teaching knowledge, it's teaching behavior: the model already "knows," it just hasn't learned how to act."

"When we train a large neural network to accurately predict the next word across a wide variety of text on the internet, what we're actually doing is learning a world model. On the surface, it looks like we're just learning statistical correlations in text. But it turns out that to really learn these statistical correlations well — to really compress them well — the neural network learns some representation of the process that produced the text."

"(The solution to unsupervised learning) Intuitively you can see why it should work. If you compress the data well enough, you must extract all the hidden secrets within it. So that's the key."

"Pre-training as we know it will unquestionably end."

"Our selves are parts of our own world models."

"One thing that guides me personally is an aesthetic of how AI should be by thinking about how people are."

"There's no room for ugliness. It's just beauty, simplicity, elegance, with correct inspiration from the brain."

"The more they are present, the more confident you can be in a top-down belief. The top-down belief is the thing that sustains you when the experiments contradict you."

"Because if you just trust the data all the time, sometimes you can be doing a correct thing, but there's a bug. How do you know if you should keep debugging or you conclude it's the wrong direction?"

"You must say that things have to be this way, therefore we've got to keep going. That's the top-down belief, and it's based on this multifaceted beauty and inspiration by the brain."



# andrej

"
Applying neural nets correctly is really quite simple: 1. Make sure you have a validation set. 2. Initialize a big network. 3. Train big network with several learning rates and dropouts. 4. Repeat until you're tired. 5. Take whatever model gives best validation performance.

When done properly it is very rare that a neural net gets performance lower than a linear classifier, because a neural net has the capacity to be a linear classifier.
"

"A common mistake when implementing your first neural net library is to fall victim to the first way of thinking as discussed in this post. E.g., you think of a neural net Layer object such as FullyConnected layer and decide that it should own its weights and biases. In direct correspondence to a set of neurons in one layer. It makes sense.

It takes a while to realize that this is a big mistake that will make life very difficult down the road. Caffe has made that mistake. Torch has made that mistake. I made that mistake when I wrote ConvNetJS. The right way to do it is, as pointed out here, is to think of each layer as an as-stateless-as-possible function. E.g. instead of a FullyConnected layer that owns parameters, it would simply be a MatrixMultiply layer that takes an X and a W,b and computes WX + b.

This makes it significantly easier to implement features such as parameter sharing (just fork a weight to several transformers, the gradients will add properly), weight regularization (just additionally connect a weight matrix to whatever loss layer you'd like), etc.

It gets even more complex once you decide that you want your library to also easily support taking gradients w.r.t. backward pass, e.g. to implement this beast (http://arxiv.org/pdf/1502.03492.pdf). Or that you want to do tangent propagation, or whatever else crazy might come down the road. All that then leads you down the road of backward pass being generated, not baked in, and indistinguishable from the forward pass computations.

The joys of Neural Net library API design :)"

"
Neural Nets are like Lego: there are a few basic building blocks that require a bit of understanding, and then you can build all kinds of awesome castles.
"

* Math for AI
"imo, basic multivariable calculus, basic convex optimization, medium linear algebra, mostly statistics.
I didn't take enough statistics in undergrad and regretted it several times. Instead I did a bunch of partial differential equations, chaos theory, numerical analysis, group theory, mathematical logic (incompleteness theory etc), and all of these ended up being quite useless. And after ~5-8 years I only just barely remember any of it :("

"
In retrospect I quite enjoyed writing my first AI short story and will probably continue to write more a bit on a side as I did the first time (though nothing specific is in works right now). I actually consider it a relatively good exercise for research because you're forcing yourself to hypothesize consistent and concrete outcomes. Pushing these in your mind to their conclusions is one way to achieve fun insights into what approaches to AI are more or less plausible.
"