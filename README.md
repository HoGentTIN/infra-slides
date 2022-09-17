# Infrastructure Automation: slides

In deze repository vind je de slides die gebruikt wordt in de lessen van de cursus Infrastructure Automation (3e jaar bachelor toegepaste informatica aan Hogeschool Gent).

Gerelateerde repositories:

- Syllabus: <https://github.com/HoGentTIN/infra-syllabus>
    - Te bekijken op: <https://hogenttin.github.io/infra-syllabus/>
- Slides van de lessen: <https://github.com/HoGentTIN/infra-slides>
    - Te bekijken op: <https://hogenttin.github.io/infra-slides/>
- Vagrant demo-omgeving: <https://github.com/HoGentTIN/infra-demo>
- Opgave labo-opdrachten: <https://github.com/HoGentTIN/infra-labs>

## Slides genereren

Om zelf de slides te genereren heb je een Linux (of UN*X) omgeving nodig, met (GNU) make en [Pandoc (v2.9)](https://pandoc.org/).

Haal eerst de branch `gh-pages` (wordt gebruikt om de slides te publiceren via Github Pages) binnen en maak die beschikbaar in de directory `gh-pages`.

```console
git worktree add gh-pages gh-pages
```

Genereer vervolgens de slides a.h.v. de Makefile:

```console
make all
```

Je kan nu de slides bekijken door de .html-bestanden in de `gh-pages` directory te openen in een webbrowser.

## Bijdragen

Bijdragen aan het hier gepubliceerde lesmateriaal zijn van harte welkom! Verbeteren van tikfouten, toevoegingen, onduidelijkheden melden, enz. kan eenvoudig via een issue of een pull request.

## Licentie-informatie

Deze syllabus is samengesteld door [Bert Van Vreckem](https://github.com/bertvv/) en valt onder de [Creative Commons Naamsvermelding-GelijkDelen 4.0 Internationale Publieke Licentie](http://creativecommons.org/licenses/by-sa/4.0/).
