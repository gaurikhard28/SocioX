import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socio_x/Models/NewsModel.dart';
import 'package:socio_x/Screen/Authentication/AuthPage.dart';

import '../Providers/NewsProvider.dart';
import '../Utils/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Article> searchList = [];
  bool search=false;
  @override
  void initState() {
    super.initState();
    Provider.of<NewsProvider>(context, listen: false).getNews();
  }
  @override
  Widget build(BuildContext context) {

    final newsProvider = Provider.of<NewsProvider>(context);
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('SocioX'),
        backgroundColor: SecondaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthPage())))
                  .onError((error, stackTrace) => print(error.toString()));
            },
          ),
        ],
      ),

      body: newsProvider.onLoad?
      Center(child: CircularProgressIndicator())
      :Column(
        children: <Widget>[
          TextField(
            textInputAction: TextInputAction.done,
            onSubmitted: (value){
              searchList = newsProvider.searchNews(value);
              search=true;
            },
            decoration: InputDecoration(
              labelText: 'Search in feed',
              labelStyle: TextStyle(color: textColor),
              prefixIcon: Icon(
                Icons.search,
                size: SizeConfig.defaultSize * 2,
                color: textColor,
              ),
              filled: true,
              fillColor: SecondaryColor.withOpacity(0.8),


              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  borderSide:
                  BorderSide(color: primaryColor)),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height-150,
            child: ListView.builder(
              itemCount: search ? searchList.length : newsProvider.articles.length,
              itemBuilder: (context, index) {
                final article = search ? searchList[index] : newsProvider.articles[index];
                return Card(
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width-60,
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('${article.source?.name ?? ''}',
                         style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                         fontSize: 10),
                    ),
                            Text(' ${article.publishedAt}',style: TextStyle(fontSize: 10),),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width-150,
                                  child: Text(
                                    article.title ?? '',
                                    style: TextStyle(fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,color: primaryColor),

                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  width: MediaQuery.of(context).size.width-150,
                                  child: Text(article.description ?? '',
                                    style: TextStyle(overflow: TextOverflow.ellipsis,color: primaryColor),
                                    maxLines: 2,

                                  ),
                                ),
                              ],
                            ),
                            CachedNetworkImage(
                              imageUrl: article.urlToImage ?? '',
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
