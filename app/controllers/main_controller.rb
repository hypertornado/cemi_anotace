class MainController < ApplicationController
  def index
    return redirect_to "/login" if session[:user_id] == nil
    current_user = User.find_by_id(session[:user_id])
    @username = current_user.name
    @text = <<-EEE
      Bývalá ministryně uvedla, že se o schůzkách se zástupci Steyru dozvěděla až v roce 2010 z médií. „To zjištění mě velmi znechutilo. Pan Barták (tehdejší první náměstek, pozn. red.) mě o schůzce vůbec neinformoval,“ řekla Parkanová. Uvedla, že se šuškalo o nějakém setkání, ale Barták to na přímý dotaz popřel.
      Parkanová se u soudu zlobila, že o schůzkách se zástupci Steyru jako ministryně vědět měla, a to, že se uskutečnily, bylo podle ní nepřijatelné. „K takovým schůzkám by podle mě mělo docházet výhradně na půdě ministerstva,“ řekla. Fakt, že se schůzek účastnil i lobbista Dalík, pak označila za skandální.
      Bývalá ministryně vysvětlila, proč Martin Barták převzal vyjednávání od náměstka Kopřivy. Podle ní to bylo ze dvou důvodů. „Jednak byl pan Barták velmi zdatný ve vyjednávání se zahraničím a za druhé to bylo na žádost premiéra Topolánka. Ten neměl velké sympatie k panu Kopřivovi,“ řekla Parkanová.
      Původní projekt nákupu pandurů domluvený Paroubkovou vládou označila za megalomanský. „Jenže smlouva byla podepsaná a my jsme měli svázané ruce. Teprve na podzim se objevil fakt, který byl podkladem na vypovězení smlouvy,“ řekla. Zmínila problémy u zkoušek i to, že zakázka nebyla plněna včas.
      Spor mezi oběma stranami chtělo ministerstvo řešit podle Parkanové smírem, jelikož hrozila arbitráž. „Pokud bychom vybrali jiného dodavatele, tak se mohlo stát, že bychom museli na základě výsledků arbitráže odebrat i nasmlouvané pandury,“ řekla. Vypovězení smlouvy označila za riskantní krok, zájem na smíru proto měly obě strany.
      Dopoledne u soudu vypovídal Marek Dalík. Odmítl, že by si řekl o úplatek v souvislosti s kauzou pandurů. Na většinu otázek ohledně schůzek se zástupci Steyru odpovídal, že už je to sedm let a že si nepamatuje (více o jeho výpovědi zde). Státní zástupce ho viní z pokusu o podvod v souvislosti s nákupem obrněných transportérů Pandur pro českou armádu. Na schůzce v roce 2007 si podle něj řekl o úplatek ve výši téměř půl miliardy korun.
      Zdroj: http://zpravy.idnes.cz/v-kauze-dalika-a-panduru-vypovidala-parkanova-fo1-/krimi.aspx?c=A140630_135113_krimi_cen
    EEE

    @images = ["img1", "img2"]

    render :layout => false
  end

  def login
    reset_session
    @instructions = File.read(Rails.root.join('public/annotation_short_info.txt'))
  end

  def do_login
    user = User.find_by_name(params["username"])
    if user != nil and user.password == params["password"]
      session[:user_id] = user.id
      redirect_to "/"
    else
      redirect_to "/login?fail=true"
    end
  end

  def logout
    reset_session
    redirect_to "/"
  end
end
