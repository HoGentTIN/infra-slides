# Infrastructure Automation: slides

In deze repository vind je de (Markdown broncode voor de) slides die gebruikt wordt in de lessen van de cursus Infrastructure Automation (3e jaar bachelor toegepaste informatica aan Hogeschool Gent).

- De gepubliceerde slides zijn te bekijken op: <https://hogenttin.github.io/infra-slides/>
- Opgave labo-opdrachten: <https://github.com/HoGentTIN/infra-labs>

## Slides genereren

Om zelf de slides te genereren heb je een Linux (of UN*X) omgeving nodig, met (GNU) make en [Pandoc (v2.19.x)](https://pandoc.org/).

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

Bijdragen aan het hier gepubliceerde lesmateriaal zijn van harte welkom! Het verbeteren van tikfouten, het maken van toevoegingen, het melden van onduidelijkheden, enz. kan eenvoudig via een issue of een pull request.

## Licentie-informatie

De inhoud van de slides is samengesteld door [Bert Van Vreckem](https://github.com/bertvv/), [Thomas Aelbrecht](https://github.com/thomasaelbrecht) en [Thomas Clauwaert](https://github.com/ciberth) en valt onder de [Creative Commons Naamsvermelding-GelijkDelen 4.0 Internationale Publieke Licentie](http://creativecommons.org/licenses/by-sa/4.0/).
