# Installing
- This blog is using [mkdocs](https://www.mkdocs.org)
  - install: `pip install mkdocs`
  - using material theme: `pip install mkdocs-material`
- Create using: `mkdocs new my-blog`

# Testing
- Can be testing locally using: `cd my-blog && mkdocs serve`

# Building
- Build using: `cd my-blog && mkdocs build`

# Deploying
- Install running: `deploy.sh`
  - It generates a directory `my-blog/site`
  - It removes the current `/docs`
  - It then moves `my-blog/site` into `/docs` (the root of our blog)
