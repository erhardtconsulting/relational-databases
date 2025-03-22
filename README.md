# Relational Database Course

This repository contains all materials for the "Relational Database Course" taught to IT students at [HFTM (Höhere Fachschule für Technik Mittelland)](https://www.hftm.ch/).

## Language Notice

**Please note:** While this README is in English, all course materials, documentation, and slides are provided in **German**.

## About the Course

This course provides comprehensive knowledge about relational databases, covering topics such as:

- History and evolution of database systems
- Relational database concepts and theory
- SQL (Structured Query Language)
- Database design and normalization
- Performance optimization
- Modern database trends
- Working with [PostgreSQL](https://www.postgresql.org/)

## Access

You can access the course materials online:

- **[Course Book](https://relational-databases.erhardt.consulting/)**
- **[Slides](https://relational-databases.erhardt.consulting/extras/#/Praesentationen)**
- **[Exercises](https://relational-databases.erhardt.consulting/extras/#/Aufgaben)**
- **[Docker Container](https://github.com/erhardtconsulting/relational-databases/pkgs/container/relational-databases)**

You are free to use these materials under the [CC-BY-SA 4.0 License](https://creativecommons.org/licenses/by-sa/4.0/).

## Purpose

This repository serves as:

1. A living document that evolves with the teaching curriculum
2. A resource for students during and after the course
3. A reference guide for anyone interested in relational databases

## Setup and Usage

### Technology Stack

This project uses:

- **[Jupyter Book](https://jupyterbook.org/)** and **[MyST](https://myst-parser.readthedocs.io/)** for documentation
- **[Marp](https://marp.app/)** for presentation slides
- **[Pandoc](https://pandoc.org/)** for other documents, like exercises.

### Building Documentation

To build and view the documentation:

1. Install [Poetry](https://python-poetry.org/) (Python dependency management)
2. Install dependencies:
   ```
   poetry install
   ```
3. Build and serve the documentation:
   ```
   cd docs/
   jupyter book build .
   ```

### Building Slides

To build and view the presentation slides:

1. Install [NodeJS](https://nodejs.org/)
2. Install dependencies:
   ```
   npm install
   ```
3. Serve the slides:
   ```
   npm run slides:serve
   ```

## Contributing

We welcome contributions to improve and expand these materials:

- Open an **Issue** for bugs, suggestions, or content improvements
- Submit a **Pull Request** with proposed changes or additions

## License

This work is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License (CC-BY-SA)](https://creativecommons.org/licenses/by-sa/4.0/).

You are free to:
- **Share** — copy and redistribute the material in any medium or format
- **Adapt** — remix, transform, and build upon the material for any purpose, even commercially

Under the following terms:
- **Attribution** — You must give appropriate credit, provide a link to the license, and indicate if changes were made.
- **ShareAlike** — If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original.