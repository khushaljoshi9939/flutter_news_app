import "package:flutter/material.dart";
import 'package:knews/models/article_model.dart';
import "package:knews/helper/news.dart";
import 'article_web.dart';

class Category extends StatefulWidget {
  final String cat;
  Category({this.cat});
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<ArticleModel> articles = new List<ArticleModel>();
  // bool _loading = true;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getNews();
  }

  getNews() async {
    CatogryNews news = CatogryNews();
    // ignore: await_only_futures
    await news.getNews(widget.cat);
    articles = news.newsList;
    setState(() {
      // _loading = false;
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
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: [
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
