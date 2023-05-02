import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/presentation/bloc/main_bloc.dart';
import 'package:casino_test/src/presentation/bloc/main_event.dart';
import 'package:casino_test/src/presentation/bloc/main_state.dart';
import 'package:casino_test/src/presentation/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@immutable
class CharactersScreen extends StatefulWidget {
  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final _scrollController = ScrollController();
  int _currentPage = 1;
  bool _isLoading = false;
  List<Character> charachtersList = [];
  @override
  void initState() {
    super.initState();
    print(_currentPage);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final delta = 100.0; // Pixels to trigger loading more data
    if (maxScroll - currentScroll <= delta) {
      // Load the next page of data
      context
          .read<MainPageBloc>()
          .add(GetTestDataOnMainPageEvent(_currentPage + 1));
      setState(() {
        // ignore: unnecessary_statements
        _currentPage + 1;
      });
    }
  }

  Future<void> _loadMoreData() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      final charactersRepo = GetIt.I.get<CharactersRepository>();
      final newCharacters =
          await charactersRepo.getCharacters(_currentPage + 1);
      setState(() {
        charachtersList.addAll(newCharacters!);
        print(charachtersList);
        _isLoading = false;
      });
      if (newCharacters!.isNotEmpty) {
        context
            .read<MainPageBloc>()
            .add(DataLoadedOnMainPageEvent(newCharacters));
        setState(() {
          _currentPage++;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = _currentPage > 1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(39, 43, 52, 1),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(39, 43, 52, 1),
          title: Row(
            children: [
              Container(
                height: 60.0,
                width: 180.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/appbar.png'))),
              ),
              Text('Characters'),
            ],
          ),
          actions: [
            Icon(
              Icons.search,
              size: 30,
            ),
            HorizontalSpacer(width: 15.0),
          ],
        ),
        body: BlocProvider(
          create: (context) => MainPageBloc(
            InitialMainPageState(),
            GetIt.I.get<CharactersRepository>(),
          )..add(GetTestDataOnMainPageEvent(_currentPage)),
          child: BlocConsumer<MainPageBloc, MainPageState>(
            listener: (context, state) {
              if (state is SuccessfulMainPageState) {
                setState(() {
                  charachtersList = state.characters;
                  _isLoading = false;
                });
              }
            },
            builder: (blocContext, state) {
              if (state is LoadingMainPageState && _currentPage == 1) {
                return Center(
                  child: RotatingImage(
                    imagePath: 'assets/bg.jpg',
                    size: MediaQuery.of(context).size.width * 0.5,
                    duration: 2,
                  ),
                );
              } else if (state is SuccessfulMainPageState) {
                return _successfulWidget(context, charachtersList);
              } else if (state is UnSuccessfulMainPageState) {
                return Center(child: const Text("error"));
              } else {
                return Center(
                  child: RotatingImage(
                    imagePath: 'assets/bg.jpg',
                    size: MediaQuery.of(context).size.width * 0.5,
                    duration: 2,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _successfulWidget(BuildContext context, List<Character> characters) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollEndNotification) {
          if (_scrollController.position.extentAfter == 0) {
            _loadMoreData();
          }
        }
        return false;
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: characters.length + 1,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            if (index < characters.length) {
              Character character = characters[index];

              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                color: Color.fromRGBO(61, 62, 67, 1),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.height * 0.18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                            image: NetworkImage(character.image!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                character.name!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            VeritcalSpacer(),
                            Row(
                              children: [
                                Text(
                                  character.species!,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                ),
                                HorizontalSpacer(),
                                character.gender! == 'Male'
                                    ? Icon(
                                        Icons.male,
                                        color: Colors.blue,
                                      )
                                    : Icon(
                                        Icons.female,
                                        color: Colors.pink,
                                      ),
                              ],
                            ),
                            VeritcalSpacer(
                              height: 15.0,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 15.0,
                                  color: character.status! == 'Alive'
                                      ? Colors.green
                                      : character.status! == 'Dead'
                                          ? Colors.red
                                          : Colors.grey,
                                ),
                                HorizontalSpacer(),
                                Text(
                                  character.status!,
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.7)),
                                ),
                              ],
                            ),
                            VeritcalSpacer(
                              height: 15.0,
                            ),
                            Text(
                              'Last known location:',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                            Text(
                              character.location!['name']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            VeritcalSpacer(
                              height: 15.0,
                            ),
                            Text(
                              'First Seen In: Episode ${(character.episode!.first).split('/').last}',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return RotatingImage(
                imagePath: 'assets/bg.jpg',
                size: 50,
                duration: 2,
              );
            }
          },
        ),
      ),
    );
  }
}
