Task Sentiment
==============

A classifier that takes a phrase and determines if there is a task in there.

## DESCRIPTION

This is a small library that uses [Open AI GPT-3](https://beta.openai.com/) classifier capabilities to determine if a phrase is a task and when the task is due and to whom is it assigned to.

## INSTALLATION

You must install the gem. Add the following to your `Gemfile`.

```
gem "task_sentiment"
```

Then run `bundle install`

## USAGE

You can use the library in the following ways:

```
require "task_sentiment"

result = TaskSentiment::Analyzer.new("@joe, send the contract by tomorrow").analyze

# result => {
  task: "Send the contract",
  due: "tomorrow",
  assigned_to: "Joe"
}

```

## CONTRIBUTING

1. Fork the repository `gh repo fork https://github.com/jwright/task_sentiment`
1. Create a feature branch `git checkout -b my-awesome-feature`
1. Codez!
1. Commit your changes (small commits please)
1. Push your new branch `git push origin my-awesome-feature`
1. Create a pull request `gh pr create --head my-fork:my-awesome-feature`
