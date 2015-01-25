### ...and you thought yo mamma was a nag

Nag will bother you until you do stuff

### Requirements

Clisp, and Ruby


### Install

cd into the directory and run ./bin/install

then add nag to your path.

### Setup

Add questions to .config/nag/questions.coffee

it will nag everytime you run the ```nag``` command until you tell it you finished

The answers get stored in .config/nag/completed

# Arguments

## Test-Mode

```--test``` will set all tasks to pending e.g. depricate reset
it will also enable ^D

## Edit Mode

Running ```nag edit``` will open the questions file within the $EDITOR.

## Ignoring Nag
Nag will by ignored if the environment variable ```NAG_IGNORE``` exists with any value
