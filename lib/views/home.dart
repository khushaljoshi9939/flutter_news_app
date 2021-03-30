import "package:flutter/material.dart";
import "package:knews/helper/data.dart";
import 'package:knews/models/categoryModels.dart';
import 'package:knews/models/article_model.dart';
import "package:knews/helper/news.dart";
import "package:cached_network_image/cached_network_image.dart";
import 'package:knews/views/category_web.dart';
import 'article_web.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> catagories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    catagories = getCategory();
    getNews();
  }

  getNews() async {
    News news = News();
    // ignore: await_only_futures
    await news.getNews();
    articles = news.newsList;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //appbar already in center butbecause row takes all the space we have use main axis alignment
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("KHUSHAL"),
          Text(
            "news",
            style: TextStyle(color: Colors.yellow),
          ),
        ]),
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
              child: Container(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.red,
              )),
            )
          : SingleChildScrollView(
              child: Container(
                  child: Column(
                children: [
                  // categories
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                      height: 100,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return CategoryTile(
                            imageUrl: catagories[index].imageUrl,
                            categoryName: catagories[index].categoryName,
                          );
                        },
                        itemCount: catagories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                      )),
                  Container(
                      padding: EdgeInsets.all(15),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return BlogTile(
                            desc: articles[index].desc,
                            imageUrl: articles[index].urlImage,
                            title: articles[index].title,
                            webUrl: articles[index].url,
                          );
                        },
                        itemCount: articles.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: ClampingScrollPhysics(),
                      )),
                ],
              )),
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imageUrl, categoryName;

  CategoryTile({this.imageUrl, this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Category(
                      cat: categoryName.toLowerCase(),
                    )));
      },
      child: Container(
        padding: EdgeInsets.only(right: 10),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 120,
                height: 75,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black26,
              ),
              child: Text(
                categoryName,
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, webUrl;
  BlogTile(
      {@required this.desc,
      @required this.imageUrl,
      @required this.title,
      @required this.webUrl});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Article(
                      url: webUrl,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: <Widget>[
            ClipRRect(
              child: Image.network(imageUrl),
              borderRadius: BorderRadius.circular(25),
            ),
            Text(title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text(
              desc,
              style: TextStyle(color: Colors.black38, fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
