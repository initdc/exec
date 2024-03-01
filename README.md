# exec

> Subclass for `Process`

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     exec:
       github: initdc/exec
       version: 0.0.1
   ```

2. Run `shards install`

## Usage

```crystal
require "exec"

Exec.run("sudo apt update")
p Exec.code("unamea")
p Exec.output("uname")
```

## Contributing

1. Fork it (<https://github.com/initdc/exec/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [initdc](https://github.com/initdc) - creator and maintainer
