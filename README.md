# IPA Vorlage
Die IPA Vorlage baut eine Struktur für die aktuellen IPA Kriterien auf. Diese Struktur besteht grösstenteils aus Überschriften und kann beliebig angepasst werden. Es gibt verschiedenste TODO's in den LaTeX Files, welche ersetz werden müssen.

Alle Bilder können in den Ordner `bilder` kopiert und mit

```
\begin{figure}[H]
    \centering
    \includegraphics[width=1\textwidth]{<filename>}
    \caption{<bildunterschrift>}
\end{figure}
```

In den Files gibt es ausserdem verschiedene Beispiele für Tabellen welche wiederverwendet werden können, damit diese nicht immer neu geschrieben werden müssen

### LaTeX benutzen

LaTeX mit `sudo apt install texlive-full` installieren

Ausserdem muss die Extension `LaTeX Workshop` in Visual Studio Code hinzugefügt werden, damit das LaTeX gerendert werden kann.

![image](https://github.com/user-attachments/assets/b1e051fa-ab4d-4440-a691-cf5b8f9ac930)

Und danach sollte es ungefähr so aussehen

![image](https://github.com/user-attachments/assets/ae3c3295-9c14-442b-bda4-b6991951eb9f)



### Code Anhang Script
In diesem Repo gibt es ein Script (extract_code.rb) welches verwendet werden kann, um Git Changes zu LaTeX zu formatieren.

Das Script kann wie folgt verwendet werden
`ruby extract_code.rb -d /git/...`
Mit -d kann ein Pfad zum Git Repo mitgegeben werden, in welchem git diff ausgeführt werden soll, optional kann mit -b auch ein Branch mitgegeben werden, falls git diff nicht mit dem master verglichen werden soll.
