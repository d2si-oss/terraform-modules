# AWS helper terraform module

This module helps circumvent some [terraform](https://www.terraform.io)
shortcomings like not being able to interpolate variables based on the result of
another interpolation. Generally it shouldn't be used directly but instead be
included by other modules.

## Argument

- `azs_count` (string, OPT) - amount of availability zones requested
  - default: total amount of availability zones in the current region

## Outputs

- `azs` - amount of available availability zones in use
