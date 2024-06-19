import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto/configs/app_settings.dart';
import 'package:url_launcher/url_launcher.dart';

Future<List<dynamic>> fetchNews() async {
  const apiKey = '5841c96e75b145ba8d28f6fc202b547b';
  final DateTime data30Dias = DateTime.now().subtract(const Duration(days: 30));
  String data = '${data30Dias.year}-${data30Dias.month}-${data30Dias.day}';
  final url = 'https://newsapi.org/v2/everything?q=(economia%20AND%20investimento%20AND%20finanças)&sortBy=publishedAt&from=$data&language=pt&apiKey=$apiKey';
  final response = await http.get(Uri.parse(url));
  int i = 0;
  if (response.statusCode == 200) {
    List<dynamic> artigos = json.decode(response.body)['articles'];
    print(artigos.length);
    for(i=0; i<artigos.length; i++) {
      if(artigos[i]['title'] == null || artigos[i]['description'] == null || artigos[i]['url'] == null ||
      artigos[i]['title'].toLowerCase().contains('removed') ||
      artigos[i]['description'].toLowerCase().contains('removed') ||
      artigos[i]['url'].toLowerCase().contains('removed')) {
        print(artigos[i]['title']);
        print(artigos[i]['description']);
        artigos.removeAt(i);
      }
    }
    print(artigos.length);
    return artigos;
  } else {
    throw Exception('Failed to load news');
  }
}

void _launchURL(String url) async {
  Uri parsedUrl = Uri.parse(url);
  if (await canLaunchUrl(parsedUrl)) {
    await launchUrl(parsedUrl);
  } else {
    throw 'Could not launch $url';
  }
}

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  late Future<List<dynamic>> _newsData;

  @override
  void initState() {
    super.initState();
    _newsData = fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: _newsData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final articles = snapshot.data;
            return ListView.separated(
              shrinkWrap: true,
              itemCount: articles!.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return ListTile(
                  title: Text(article['title']!, 
                    style: const TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 18)),
                  subtitle: Text(article['description']!),
                  trailing: article['urlToImage'] != null && article['urlToImage']!.isNotEmpty
                      ? Image.network(article['urlToImage'],
                        width: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return const Icon(Icons.image_not_supported);
                        },)
                      : null,
                  onTap: () {
                    _launchURL(article['url']);
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  thickness: 2,
                  color: AppSettings.getCorTema().withOpacity(0.3)
                );
              },
            );
          }
        },
      ),
    );
  }
}