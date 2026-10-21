# Visual Prolog Code Generation: GitHub vs Textbook Data

## Problem Statement
Large Language Models (LLMs) fail to generate syntactically correct code for Visual Prolog. This niche language lacks representation in training corpora, forcing developers to manually fix or write code from scratch.

## Hypothesis
Fine-tuning on structured textbook examples (explanation → code) yields greater improvement in syntactic correctness than fine-tuning on raw GitHub code.

## Planned Methodology
- Base model: Qwen2.5-Coder-1.5B-Instruct
- Two datasets: raw GitHub code vs. structured textbook examples
- Two LoRA adapters trained with QLoRA on Google Colab T4
- Custom benchmark: 20-30 Visual Prolog tasks with reference solutions
- Metrics: syntactic correctness, semantic correctness