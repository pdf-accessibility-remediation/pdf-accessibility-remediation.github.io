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
