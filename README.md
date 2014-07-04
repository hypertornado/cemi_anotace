## Instalace

```bash
ruby -v #=> ruby 2.0.0.....
git clone https://github.com/hypertornado/cemi_anotace
cd cemi_anotace
bundle install #nainstaluje vsechny ruby zavislosti
rake db:migrate #vytvori sqlite databazi s tabulkama
rails server #spusti anotacni server na portu :3000
```

## Přidání uživatelů

Po spuštění serveru jdi na adresu <http://localhost:3000/users> (admin ma uzivatelske jmeno "cemi", heslo je "cemi85"). Tam jde pomoci "new user" pridat uzivatele. Jdou i upravovat a mazat.

## Import anotačních dat

Aplikace očekává, že data budou v souboru ```ROOT_APLIKACE/public/annotation_inputs.csv```, pokud jsou nekde jinde, je nutné je překopírovat, nebo vytvořit symlink. Importovaná data jsou oddělená mezerou (v původní specifikaci byl myslím tabulátor, ale ten ukázkový soubor používá právě mezery).

Pak jde data naimportovat pomocí ```rake data:import```.

## Cesty k textům a obrázkům

Cesty k textům a obrázkům by měly opět odpovídat adresáři ```ROOT_APLIKACE/public/```. Pokud tedy chci anotovat text ```./text/aha/aha-00006.txt.gz``` a obrázek ```img/2.jpg```, musí existovat soubory ```ROOT_APLIKACE/public/./text/aha/aha-00006.txt.gz``` a ```ROOT_APLIKACE/public/img/2.jpg```. Mělo by se opět vyřešit kopírováním, nebo symlinkem.

Nyní by měl přidaný uživatel po přihlášení na <http://localhost:3000> mít možnost anotovat texty. Pokud nejdou žádné texty dostupně, zobrazí se mu obrazovka s příslušnou informací.

## Export dat

Export se provede příkazem ```rake data:export```. Exportovaná data jsou vypsána na konzolu. V prípadě testování anotačního rozhraní jde použít příkaz ```rake data:delete```, který všechna anotační data vymaže.




