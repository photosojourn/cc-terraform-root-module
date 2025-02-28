<!-- REPLACE THIS SECTION - START -->
# DevOpsGroup Terraform Root Module Template

## What is this?

This repository represents our recommended template for a Terraform [Root Module](https://www.terraform.io/docs/glossary.html#root-module).

A Terraform Root Module is the most bottom level Terraform configuration, from which you would call other pieces of Terraform configurations and modules to create your infrastructure.

A Terraform Root Module is -not- typically used by other Terraform configurations; those would instead be called child modules.

### Terminology

This terminology is set by HashiCorp in their [glossary](https://www.terraform.io/docs/glossary.html) and can be a little confusing; a Root Module might be better referred to as the base of your Terraform config, but it is better if we try to maintain parity with the upstream standard.

## How Do I Use This Repository?

When you are creating a new repository to hold some top level Terraform configurations, you should follow the steps below:

1. Copy the contents of the repository.
2. Delete `.github/CODEOWNERS`, and the `.github` folder if it is not required.
3. Edit [.tflint.hcl](.tflint.hcl) to uncomment the relevant cloud provider(s) as necessary.
4. If using Azure, you will also have to install the relevant [tflint ruleset](https://github.com/terraform-linters/tflint-ruleset-azurerm#installation) when enabling the plugin.
5. Edit [terraform/terraform.tf](terraform/terraform.tf) to set the Required Providers and also configure any required State Backends.
6. Edit [terraform/providers.tf](terraform/providers.tf) to set any configuration options up for the required providers.
7. Delete everything between the `REPLACE THIS SECTION` tags in the [README.md](README.md) and [terraform/README.md](terraform/README.md) files and replace them with relevant documentation.

[pre-commit](https://github.com/pre-commit/pre-commit) is needed to run a number of basic linters and tests locally; as such, you need to install the pre-commit hooks for each time you clone a repository using this template, if you don't do so [automatically already](https://pre-commit.com/#automatically-enabling-pre-commit-on-repositories). This can be done with the following command in the root directory of your repository;

```
pre-commit install
```

## Requirements

This example was created and checked using the following versions of the tooling. If newer versions of the tooling are available, feel free to check and raise a PR to update the version table below.

The tool versions in the table below are meant as a guideline, and client requirements could override these. In this case please test the code with the version that the client specifies.

| Tool                                                                       | Version | Description                                                                                                                                                               |
| -------------------------------------------------------------------------- | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [pre-commit](https://github.com/pre-commit/pre-commit)                     | 2.10.1  | Used to control and run Git hooks.                                                                                                                                        |
| [terraform](https://www.terraform.io/)                                     | 1.2.4   | Used for testing and applying the Terraform configurations.                                                                                                               |
| [coreutils](https://www.gnu.org/software/coreutils/)                       | N/A     | Required for the `realpath` binary on macOS. Install via `brew install coreutils`.                                                                                        |
| [terraform-docs](https://github.com/terraform-docs/tfdocs-format-template) | 0.11.2  | Used to create the `terraform/README.md` file from the Terraform configurations themselves.                                                                               |
| [tflint](https://github.com/terraform-linters/tflint)                      | 0.35.0  | Used to perform more advanced linting of the Terraform configurations.                                                                                                    |
| [tfsec](https://github.com/tfsec/tfsec)                                    | 0.39.6  | Used to scan Terraform configurations for known potential security issues. DOG would also recommend [checkov](https://github.com/bridgecrewio/checkov) as an alternative. |

## Folder Structure

### [GitHub Sub-Folder](.github) ⚠️
This folder is only present for functions within this existing repository, and should -not- be present in a deployed version of this template, excluding any files added into the separate repository.

### [.tflint.hcl](.tflint.hcl)

The `.tflint.hcl` file is used to configure the [tflint](https://github.com/terraform-linters/tflint) application to perform linting checks against the Terraform in this repository.

### [Terraform Sub-Folder](terraform/)

The Terraform code itself has been put into a subfolder, `terraform/`, to allow for other types of code that live in the same repository to be kept separate.

This also keeps the root folder cleaner, so only mandatory dot files and any CI/CD files that are required have to live in the root of the repository.

#### Terraform Configurations
The `terraform` folder itself should contain the following files:

- [outputs.tf](terraform/outputs.tf)
- [providers.tf](terraform/providers.tf)
- [terraform.tf](terraform/terraform.tf)
- [variables.tf](terraform/variables.tf)
- [README.md](terraform/README.md)
- [.terraform.lock.hcl](terraform/.terraform.lock.hcl)

### [terraform/.terraform.lock.hcl](terraform/.terraform.lock.hcl)

The `terraform/.terraform.lock.hcl` file, also known as the [Dependency Lock file](https://www.terraform.io/docs/language/dependency-lock.html), is used by Terraform to validate and lock the version of the required provider binaries used for a set of Terraform configurations. The file contains hashes of the provider binary and zip files, plus the versions and constraints specified for the provider at the time of creating the file.

For a [root module](https://www.terraform.io/docs/glossary.html#root-module), we would **highly recommend** committing the [Dependency Lock file](https://www.terraform.io/docs/language/dependency-lock.html), `terraform/.terraform.lock.hcl`.

This ensures that for all executions of the your root module's Terraform configurations, the exact same provider releases and versions are used, increasing consistency within Terraform workflows (Ignoring possible remote API variance).

#### When should I NOT commit terraform/.terraform.lock.hcl?

The `terraform/.terraform.lock.hcl` file should not be committed into either child modules within the same repository, or modules and configurations that are to be shared with others.

For child modules, only the root module level `terraform/.terraform.lock.hcl` file is considered, and so storing them at any other location is unnecessary and adds additional maintenance overheads for no benefit.

For shared code examples, the provider version calculated based upon variable provider constraints means that `terraform/.terraform.lock.hcl` is highly likely to be recreated. You also do not typically need the benefits that the Dependency Lock file provides in this scenario, as all shared code examples should be validated as working in the new environment that they've been applied into.
<!-- REPLACE THIS SECTION - END -->