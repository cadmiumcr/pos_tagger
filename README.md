# pos_tagger

![](https://github.com/cadmiumcr/pos_tagger/workflows/pos_tagger/badge.svg)


A Part Of Speech (POS) Tagger. It relies for now on `Cadmium::Classifier::Viterbi`.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     cadmium_pos_tagger:
       github: cadmiumcr/pos_tagger
   ```

2. Run `shards install`

## Usage

```crystal
require "pos_tagger"

example = "Cadmium is getting better and better."

pp Cadmium::POSTagger.new.tag(example)[2]

# Cadmium::Token(@verbatim="getting", @pos="VBG", @univ_pos=:verb, @morphology=:none, @is_start_sentence=false, @lemma=nil, @is_punctuation=false, @is_oov=false, @language=:en)



```

## Contributing

1. Fork it (<https://github.com/your-github-user/pos_tagger/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Rémy Marronnier](https://github.com/rmarronnier) - creator and maintainer
