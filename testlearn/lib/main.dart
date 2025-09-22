import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MainAppState(),
        child: MaterialApp(
          title: 'My App',
          theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)),
          home: MyhomePage(),
          debugShowCheckedModeBanner: false,
        ));
  }
}
// class encore inconu pour moi

class MainAppState extends ChangeNotifier {
  var current = WordPair.random();
  var history = <WordPair>[];
  GlobalKey? historyListKey;

  void getNext() {
    history.insert(0, current);
    var animetedList = historyListKey?.currentState as AnimatedListState?;
    animetedList?.insertItem(0);
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];
  void toggleFavories(WordPair? pair) {
    pair = pair ?? current;
    if (favorites.contains(pair)) {
      favorites.remove(pair);
    } else {
      favorites.add(pair);
    }
    notifyListeners();
  }

  void removeFavories(WordPair? pair) {
    favorites.remove(pair);
    notifyListeners();
  }

  // gestion du selecteur
  var currentIndex = 0;
  var currentIndexInAnotherWidget = 0;
  var indexInYetAnotherWidget = 42;
  var optionnAslected = false;
  var optionBselected = false;
  var loadingFromNetwork = false;
}

class MyhomePage extends StatefulWidget {
  const MyhomePage({super.key});

  @override
  State<MyhomePage> createState() => _MyhomePageState();
}

class _MyhomePageState extends State<MyhomePage> {
  // gestion de l'index
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    var appSate = context.watch<MainAppState>();
    var pair = appSate.current;

    // ajoute de l'icon
    IconData icon;
    if (appSate.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }
    Widget page;
    switch (currentIndex) {
      case 0:
        page = GeneratorPage(pair: pair, appSate: appSate, icon: icon);
        break;
      case 1:
        page = secondePAge();
        break;
      default:
        throw UnimplementedError('cette page est non dosponible');
    }

    // var mainArea = ColoredBox(
    //   color: Theme.of(context).colorScheme.primaryContainer,
    //   child: AnimatedSwitcher(
    //     duration: Duration(microseconds: 200),
    //     child: page,
    //   ),
    // );

    return LayoutBuilder(builder: (context, constraints) {
      Widget navigation;
      var expanded;
      if (constraints.maxWidth < 500) {
        // Utiliser BottomNavigationBar pour les petits écrans
        navigation = BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favories',
            ),
          ],
          // backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          currentIndex: currentIndex, // Index de l'élément sélectionné
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
        );
        expanded = Expanded(
            child: Container(
          child: page,
        ));
      } else {
        // Utiliser NavigationRail pour les grands écrans
        navigation = SafeArea(
          child: NavigationRail(
            extended: constraints.maxWidth >= 600,
            selectedIndex: currentIndex,
            onDestinationSelected: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.favorite),
                label: Text('Favories'),
              ),
            ],
            // backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          ),
        );
        expanded = Expanded(
            child: Container(
          child: page,
          color: Theme.of(context).colorScheme.primaryContainer,
        ));
      }

      return Scaffold(
        // appBar: AppBar(),
        body: Row(
          children: [
            if (constraints.maxWidth >= 500)
              navigation, // Afficher NavigationRail à gauche

            expanded, // Contenu principal
          ],
        ),
        bottomNavigationBar: constraints.maxWidth < 500
            ? navigation
            : null, // Afficher BottomNavigationBar en bas
      );
    });
  }
}

// seconde page
class secondePAge extends StatelessWidget {
  const secondePAge({super.key});

  @override
  Widget build(BuildContext context) {
    // Acceder a l'etat de l'Application pour obtenir les Favoris
    var appStat = context.watch<MainAppState>();
    var favories = appStat.favorites;
    var color;
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 500) {
        return Scaffold(
            appBar: AppBar(),
            body: favories.isEmpty
                ? const Center(
                    child: Text(
                      'Aucun Favoris Ajoute',
                      style: TextStyle(fontSize: 24),
                    ),
                  )
                : LayoutBuilder(builder: (context, constraint) {
                    if (constraint.maxWidth < 500) {
                      color = null;
                    } else {
                      color = Theme.of(context).colorScheme.primaryContainer;
                    }
                    return Container(
                      color: color,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(30),
                            child: Row(
                              children: [
                                Text(
                                  'vous avez ',
                                  style: TextStyle(fontSize: 22),
                                ),
                                Text(
                                  '${appStat.favorites.length}',
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  ' favorie(s): ',
                                  style: TextStyle(fontSize: 22),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: favories.length,
                              itemBuilder: (context, index) {
                                var pair = favories[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.favorite,
                                    ),
                                    title: Text(pair.asPascalCase),
                                    trailing: IconButton(
                                        onPressed: () {
                                          // supprimer un element
                                          appStat.removeFavories(pair);
                                        },
                                        icon: Icon(
                                          Icons.delete_outline,
                                          color: const Color.fromARGB(
                                              255, 233, 52, 52),
                                        )),
                                  ),
                                );
                              },
                            ),
                          ),
                          Spacer(
                            flex: 2,
                          )
                        ],
                      ),
                    );
                  }));
      } else {
        return Scaffold(
            body: favories.isEmpty
                ? const Center(
                    child: Text(
                      'Aucun Favoris Ajoute',
                      style: TextStyle(fontSize: 24),
                    ),
                  )
                : LayoutBuilder(builder: (context, constraint) {
                    if (constraint.maxWidth < 500) {
                      color = null;
                    } else {
                      color = Theme.of(context).colorScheme.primaryContainer;
                    }
                    return Container(
                      color: color,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(30),
                            child: Row(
                              children: [
                                Text(
                                  'vous avez ',
                                  style: TextStyle(fontSize: 22),
                                ),
                                Text(
                                  '${appStat.favorites.length}',
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  ' favorie(s): ',
                                  style: TextStyle(fontSize: 22),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: favories.length,
                              itemBuilder: (context, index) {
                                var pair = favories[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.favorite,
                                    ),
                                    title: Text(pair.asPascalCase),
                                    trailing: IconButton(
                                        onPressed: () {
                                          // supprimer un element
                                          appStat.removeFavories(pair);
                                        },
                                        icon: Icon(
                                          Icons.delete_outline,
                                          color: const Color.fromARGB(
                                              255, 233, 52, 52),
                                        )),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }));
      }
    });
  }
}

// seconde page

// premier page
class GeneratorPage extends StatelessWidget {
  const GeneratorPage({
    super.key,
    required this.pair,
    required this.appSate,
    required this.icon,
  });

  final WordPair pair;
  final MainAppState appSate;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 400,
                child: historyListView(),
              ),
              BigCard(pair: pair),
              SizedBox(
                height: 10,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                // tu ne dois pas occuper tout l'espace horizontal disponible
                children: [
                  ElevatedButton.icon(
                      onPressed: () {
                        appSate.toggleFavories(pair);
                      },
                      label: Icon(icon)),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        appSate.getNext();
                      },
                      child: Text('Next')),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      elevation: 13,
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: AnimatedSize(
          duration: Duration(milliseconds: 200),
          child: MergeSemantics(
            child: Wrap(
              children: [
                Text(
                  pair.first,
                  style: style.copyWith(fontWeight: FontWeight.w200),
                ),
                Text(
                  pair.second,
                  style: style.copyWith(fontWeight: FontWeight.bold),
                  semanticsLabel: "${pair.first} ${pair.second}",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class historyListView extends StatefulWidget {
  const historyListView({super.key});

  @override
  State<historyListView> createState() => _historyListViewState();
}

class _historyListViewState extends State<historyListView> {
  
  final _key = GlobalKey();
//  masquer la liste historique
  static const Gradient _maskingGradient = LinearGradient(
    colors: [Colors.transparent, Colors.black],
    stops: [0.0, 0.5], //masquer a moitie
    begin: Alignment.center, // debut par le centre
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MainAppState>();
    appState.historyListKey = _key;
    return ShaderMask(
      shaderCallback: (bounds) => _maskingGradient.createShader(bounds),
      blendMode: BlendMode.dstIn,
      child: AnimatedList(
          key: _key,
          reverse: true,
          padding: EdgeInsets.only(top: 100),
          initialItemCount: appState.history.length,
          itemBuilder: (context, index, animation) {
            final pair = appState.history[index];
            return SizeTransition(
              sizeFactor: animation,
              child: Center(
                child: TextButton.icon(
                  onPressed: () {
                    appState.toggleFavories(pair);
                  },
                  icon: appState.favorites.contains(pair)
                      ? Icon(
                          Icons.favorite,
                          size: 12,
                        )
                      : SizedBox(),
                  label: Text(
                    pair.asLowerCase,
                    semanticsLabel: pair.asPascalCase,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
