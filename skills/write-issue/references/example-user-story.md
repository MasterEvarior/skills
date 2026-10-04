# User Story:  Plausibiliserungen

Source: https://github.com/puzzle/pcts/issues/571

## Beschreibung

**Als** HR Person

**Möchte ich** bei Lebensläufen mögliche Fehlerquellen erkennen und pro-aktiv verhindern. Dazu sollen Lebensläufe plausibilisiert werden und entsprechende Meldungen im Frontend angezeigt werden

**Damit** sollen Fehler schon früher erkannt und verhindert werden.


## Akzeptanzkriterien
- [ ] Fehler in den Plausibilisierungen werden im Frontend angezeigt
- [ ] Fehler im Frontend werden in der aktuell ausgwählten Sprache angezeigt
- [ ] Folgende Plausibilisierungen sollen unterstützt werden
   - [ ] Lücken im Lebenslauf  > 1 Monat 
   - [ ] CAS und DAS CAS zusammenfassen
   - [ ] Master braucht einen Bachelor
   - [ ] Doktor/PHD braucht einen Master
   - [ ] Keine Zeitspanne mit > 100% Pensum
   - [ ] Zeitspannen bei Puzzle bis zu 110%

## Zusätzliche Informationen
-  Siehe folgende Tickets
  - #583 
  - #593 
