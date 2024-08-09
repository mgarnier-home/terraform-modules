# Terraform declarations
terraform {
  required_version = ">= 1.0"
}

output "common_extensions" {
  value = [
    "pkief.material-icon-theme",
    "esbenp.prettier-vscode",
    "github.copilot",
    "naumovs.color-highlight",
    "oderwat.indent-rainbow",
    "ecmel.vscode-html-css",
    "christian-kohler.npm-intellisense",
    "christian-kohler.path-intellisense",
    "mike-co.import-sorter",
    "medo64.render-crlf",
    "usernamehw.errorlens",
    "formulahendry.auto-rename-tag",
    "pflannery.vscode-versionlens",
    "wix.vscode-import-cost",
    "redhat.vscode-yaml",
    "waderyan.gitblame",
    "mhutchie.git-graph",
    "donjayamanne.githistory",
    "ms-azuretools.vscode-docker",
    "formulahendry.docker-explorer",
    "formulahendry.code-runner",
    "GitHub.vscode-pull-request-github",
    "aaron-bond.better-comments",
    "pranaygp.vscode-css-peek",
    "tomoki1207.pdf",
    "johnpapa.vscode-peacock",
    "github.vscode-github-actions",
    "me-dutour-mathieu.vscode-github-actions"
  ]
}