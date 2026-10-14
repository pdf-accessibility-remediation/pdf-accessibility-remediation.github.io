# pdf-accessibility-remediation.github.io

This repository builds and deploys the documentation site for the [PDF accessibility remediation pipeline](https://github.com/pdf-accessibility-remediation/pdf-accessibility-remediation).

**The documentation is maintained in the source repository's [`docs/`](https://github.com/pdf-accessibility-remediation/pdf-accessibility-remediation/tree/main/docs) directory, not here**. This keeps code changes and their corresponding documentation changes in the same pull request. To edit a page, update it in the source repository or use **Edit this page on GitHub** at the bottom of the published page.

## How it works

This repository contains the configuration and workflow needed to publish the documentation site using GitHub Pages and Jekyll.

- `_config.yml` configures the [Just the Docs](https://just-the-docs.com) theme, sidebar navigation, and search.
- `.github/workflows/pages.yml` builds and deploys the site to GitHub Pages using the documentation from the source repository.

The deployment workflow runs:

- Automatically when the source repository sends a `docs-updated` `repository_dispatch` event after changes to `docs/` reach main.
- Manually through **Actions → Build and deploy site → Run workflow**, optionally choosing a branch, tag or commit of the source repository.
- Daily at 12:00 UTC as a fallback in case a dispatch event is missed.

GitHub disables scheduled workflows after 60 days without commits to this repository. If that happens, the daily run stops but the other triggers still work. To restore it, go to **Actions → Build and deploy site → Enable workflow**.

In **Settings → Pages**, the source must be set to **GitHub Actions**.

## Dispatch token

A workflow can only use its automatic token in its own repository, so the source repository needs a separate token to send the `docs-updated` event here. It is stored in the source repository as the Actions secret `DOCS_DISPATCH_TOKEN` and used by `.github/workflows/docs-dispatch.yml`.

- **Type:** fine-grained personal access token, resource owner `pdf-accessibility-remediation`.
- **Access:** only this repository (`pdf-accessibility-remediation.github.io`), with **Contents: Read and write**. It cannot reach the source repository or any other repository.
- **Owner:** the token belongs to the GitHub account that created it. It stops working if that person leaves the organization, loses access to this repository, or deletes the token.

If the token stops working, the **Docs dispatch** run in the source repository fails with an authentication error. The site then updates only through the daily run or a manual run until the token is replaced.

To replace it:

1. Any organization member with write access to this repository creates a new token: **Settings → Developer settings → Personal access tokens → Fine-grained tokens → Generate new token**, with the same resource owner, repository access and permission as above.
2. In the source repository, go to **Settings → Secrets and variables → Actions**, edit `DOCS_DISPATCH_TOKEN` and paste the new token.
3. Run **Actions → Docs dispatch → Run workflow** in the source repository and check that a new **Build and deploy site** run starts here.
4. Update the owner above, and delete the old token if it still exists.

## Preview locally

### Prerequisites

Install Ruby and the required build tools for your operating system by following [Jekyll's installation guide](https://jekyllrb.com/docs/installation/).

### Setup

1. Clone the [source repository](https://github.com/pdf-accessibility-remediation/pdf-accessibility-remediation) alongside this repository so that `../pdf-accessibility-remediation/docs/` exists.

2. From this repository, install Bundler and the dependencies:

    ```sh
    gem install bundler
    bundle install
    ```

### Run the preview

From this repository, run:

```sh
./script/preview.sh
```

Open http://localhost:4000 in your browser.

If the source repository is located elsewhere, pass its path to the script:

```sh
./script/preview.sh path/to/pdf-accessibility-remediation
```

The script copies `_config.yml`, `_sass/`, and the source repository's `docs/` into `/tmp/pages-preview` and serves the site from that directory. After editing a documentation page in the source repository, rerun the script to preview the updated content.

**Note:** The theme is downloaded from GitHub during each build, so an internet connection is required.
