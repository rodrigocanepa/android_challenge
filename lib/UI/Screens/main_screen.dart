import 'package:android_challenge/Models/show_model.dart';
import 'package:android_challenge/Provider/shows_provider.dart';
import 'package:android_challenge/UI/Items/item_movie.dart';
import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  late ShowsProvider showsProvider;
  List<ShowModel> showList = [];
  List<ShowModel> showListFiltered = [];
  bool searching = false;
  TextEditingController _searchQueryController = TextEditingController();

  /// This widget will be used to build the search bar field
  Widget _buildSearchField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0)
      ),
      child: TextField(
        controller: _searchQueryController,
        autofocus: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
          hintText: 'Search',
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),
        style: const TextStyle(color: Colors.black, fontSize: 16.0),
        onChanged: (query) => updateSearchQuery(query),
      ),
    );
  }

  /// This is a list of buid actions for app bar (search and title)
  List<Widget> _buildActions() {
    if (searching) {
      return <Widget>[
        GestureDetector(
          onTap: (){
            _clearSearchQuery();
            Navigator.pop(context);
            return;
          },
          child: const Center(
            child: Text(
              'Cancel',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0
              ),
            ),
          ),
        ),
        const SizedBox(width: 20.0,)
      ];
    }

    return <Widget>[
      IconButton(
        onPressed: (){
          _startSearch();
        },
        icon: const Icon(
          Icons.search,
        ),
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      searching = true;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      searching = false;
    });
  }

  /// We are using an alphabetical list so we need to update the list with the queries and get the alphabetical list
  void updateSearchQuery(String newQuery) {
    showListFiltered.clear();
    if(newQuery.isEmpty){
      for (var element in showsProvider.showsList) {showListFiltered.add(element);}
      _handleList(showListFiltered);
    } else{
      for (var element in showsProvider.showsList) {
        if(element.name.toUpperCase().contains(newQuery.toUpperCase())){
          showListFiltered.add(element);
        }
      }
      _handleList(showListFiltered);
    }
    setState(() {});
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
      showListFiltered.clear();
      for (var element in showsProvider.showsList) {showListFiltered.add(element);}
      _handleList(showListFiltered);
    });
  }

  _handleList(List<ShowModel> list) {
    if (list.isEmpty) return;
    // A-Z sort.
    SuspensionUtil.sortListBySuspensionTag(list);

    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(list);

    setState(() {});
  }

  /// This is needed to load date only the first time in this screen
  loadInitialData()async{
    await showsProvider.fetchShows();
    setState(() {
      showsProvider.showsList.forEach((element) {
        showListFiltered.add(element);
      });
      showListFiltered.sort((a, b) => a.name.compareTo(b.name));

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => loadInitialData());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchQueryController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    /// We are using provider to listen the changes
    showsProvider = Provider.of<ShowsProvider>(context, listen: true);
    bool loading = showsProvider.loading;


    return LoadingOverlay(
      isLoading: loading,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: searching ? _buildSearchField() : const Text('TV Shows'),
          actions: _buildActions(),
        ),
        body: _listShows()
      ),
    );
  }

  Widget _listShows(){

    /// This is an alphabetical list widget
    return AzListView(
      data: showListFiltered,
      itemCount: showListFiltered.length,
      itemBuilder: (BuildContext context, int index) {
        return ItemShow(
          showModel: showListFiltered[index],
        );
      },
      physics: BouncingScrollPhysics(),
      /*susItemBuilder: (BuildContext context, int index) {
                ConnectionsModel model = connections[index];
                return AzListUtils.getSusItem(context, model.getSuspensionTag());
              },*/
      indexBarData: SuspensionUtil.getTagIndexList(showListFiltered),
      indexBarOptions: const IndexBarOptions(
        needRebuild: true,
        ignoreDragCancel: true,
        textStyle: TextStyle(
            color: Colors.blue,
            fontSize: 10.0,
            fontWeight: FontWeight.bold
        ),
        downTextStyle: TextStyle(fontSize: 12, color: Colors.white),
        downItemDecoration:
        BoxDecoration(shape: BoxShape.circle, color: Colors.green),
        indexHintWidth: 120 / 2,
        indexHintHeight: 100 / 2,
        indexHintDecoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/ic_index_bar_bubble_gray.png'),
            fit: BoxFit.contain,
          ),
        ),
        indexHintAlignment: Alignment.centerRight,
        indexHintChildAlignment: Alignment(-0.25, 0.0),
        indexHintOffset: Offset(-20, 0),
      ),
    );
  }
}
