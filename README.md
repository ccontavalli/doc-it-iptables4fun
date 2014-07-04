**If you speak English, the next section is for you.**

**Se parli Italiano, puoi saltare la prossima sezione.**


What is this?
=============

Back in 2002 I wrote one of the first tutorials in Italian about how to use
the then excitingly new 'iptables' command and firewalling support in linux.

This tutorial was quite popular at the time, but as I moved on with life
and the world changed, I neglected to update it and keep it alive, until
I stumbled upon a copy of my old CVS repository, and well, my original home
page.

This repository contains a copy of a few versions of the tutorial, complete
with Makefile, .pdf, .ps, .html versions.

Tough luck if you don't speak Italian, as that will be the language used
from now on and throughout the repository.


Cosa sto leggendo?
==================

Sapete esattamente cos'e\` un firewall? Cosa fa, come si usa in Linux, e 
come filtrare il traffico di rete?

Nel lontano lontano 2002, quando ancora di Linux si parlava un po' meno,
scrissi un tutorial su come utilizzare `iptables`, all'epoca nuovo ed
emozionante sistema per effettuare firewalling in Linux.

Nel tempo e con gli anni, mi sono dimenticato di questo tutorial, finche'
qualche giorno fa non ho ritrovato perso nel mio disco rigido un vecchio
archivio CVS con, tra le altre cose, una copia del tutorial e della
mia vecchia home page.

Con un po' di archeologia informatica, ho deciso quindi di spostare su
github alcune delle versioni di questo tutorial, completo di Makefile
(aggiornato) e versioni in vario formato.

Attenzione che sebbene alcune sezioni siano perfettamente attuali e
valide al giorno d'oggi, altre non possono che essere considerate
da lungo obsolete (per esempio, il patch-o-matic e\` morto da lunga
data).

Non ci sono attualmente piani per aggiornare il tutorial, ma se
lo trovate utile e volete aggiungere / togliere sezioni, o avere
nuovi argomenti trattati, sentitevi liberi di mandare patch o
modifiche, come consono in github.

Per leggere questo tutorial, potete:

   * Scaricarlo nel formato per voi piu\` conveniente. Per esempio,
     potete usare
     [il .pdf](http://goo.gl/BhWRs6) oppure [il .txt](http://goo.gl/H4xN8M).

   * Navigare il tutorial online, [utilizzando questo link](http://goo.gl/xmTs5M).


Come modificare il tutorial
===========================

   1) Scarica una copia del file .sgml, normalmente con:

      git clone https://github.com/ccontavalli/doc-it-iptables4fun.git

   2) Entra nella directory, e modifica il file .sgml a piacimento:

      cd doc-it-iptables4fun.git
      vim iptables4fun.sgml

Segui le istruzioni su github per mandare una modifica o in generale
contribuire al tutorial: https://help.github.com/articles/fork-a-repo

Per aggiornare il .pdf, .html, ... devi:

   1) Assicurarti di aver tutti i tool necessari. Su un sistema
      Debian moderno, lancia:

          sudo -s
          apt-get install make
          apt-get install linuxdoc-tools
          apt-get install linuxdoc-tools doc-base linuxdoc-tools-text linuxdoc-tools-latex linuxdoc-tools-info perlsgml w3-recs groff
          apt-get install linuxdoc-tools doc-base linuxdoc-tools-text linuxdoc-tools-latex linuxdoc-tools-info w3-recs groff
          apt-get install texlive-xetex
          apt-get install tetex-bin
          apt-get install texlive-fonts-recommended

   2) Dalla directory dove hai scaricato il tutorial, lancia:

          $ make
          ...

