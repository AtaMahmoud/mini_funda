import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

import '../models/house.dart';
import '../models/house_details.dart';

typedef KeyProvider = Future<String?> Function();

class FundaApiRequestFailure implements Exception {
  const FundaApiRequestFailure({
    required this.statusCode,
    required this.body,
  });

  final int statusCode;
  final Map<String, dynamic> body;
}

class FundaApiUnExpectedResponse implements Exception {
  const FundaApiUnExpectedResponse({required this.error});

  final Object error;
}

class FundaApiClient {
  FundaApiClient({
    required KeyProvider keyProvider,
    http.Client? httpClient,
  }) : this._(
          baseUrl: "http://partnerapi.funda.nl",
          httpClient: httpClient,
          keyProvider: keyProvider,
        );

  FundaApiClient.dev({
    required KeyProvider keyProvider,
    http.Client? httpClient,
  }) : this._(
          baseUrl: "http://dev.partnerapi.funda.nl",
          httpClient: httpClient,
          keyProvider: keyProvider,
        );

  FundaApiClient._({
    required String baseUrl,
    required http.Client? httpClient,
    required KeyProvider keyProvider,
  })  : _baseUrl = baseUrl,
        _httpClient = httpClient ?? http.Client(),
        _keyProvider = keyProvider;

  final String _baseUrl;
  final http.Client _httpClient;
  final KeyProvider _keyProvider;

  Future<List<House>> getHomesBy(String city) async {
    final uri = Uri.parse("$_baseUrl/feeds/Aanbod.svc/${await _keyProvider()}/")
        .replace(
      queryParameters: {'type': 'koop', 'zo': "/$city"},
    );

    final response = await _httpClient.get(uri);

    if (response.statusCode != HttpStatus.ok) {
      throw FundaApiRequestFailure(
        statusCode: response.statusCode,
        body: {'reason': response.reasonPhrase},
      );
    }

    final body = XmlDocument.parse(response.body).toJson();

    return body.map((house) => House.fromJson(house)).toList();
  }

  Future<HouseDetails> getHomeDetailsBy(String id) async {
    final uri = Uri.parse(
      "$_baseUrl/feeds/Aanbod.svc/json/detail/${await _keyProvider()}/koop/$id",
    );

    final response = await _httpClient.get(uri);
    final body = response.json();

    if (response.statusCode != HttpStatus.ok) {
      throw FundaApiRequestFailure(
        statusCode: response.statusCode,
        body: body,
      );
    }

    return HouseDetails.fromJson(body);
  }
}

extension on XmlDocument {
  List<Map<String, dynamic>> toJson() {
    try {
      final List<Map<String, dynamic>> jsonList = [];
      final locationFeed = findAllElements("LocatieFeed").first;

      final housesNode = locationFeed.findElements('Objects').first;

      for (var house in housesNode.nodes) {
        jsonList.add({
          'id': house.findElements("Id").first.innerText,
          'address': house.findElements("Adres").first.innerText,
          'postCode': house.findElements("Postcode").first.innerText,
          'price': int.parse(house.findElements("Koopprijs").first.innerText),
          'bedrooms': house.findElements("AantalKamers").first.innerText,
          'coverImageUrl': house.findElements("FotoLarge").first.innerText,
        });
      }
      return jsonList;
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(
        FundaApiUnExpectedResponse(error: e),
        stackTrace,
      );
    }
  }
}

extension on http.Response {
  Map<String, dynamic> json() {
    try {
      final decodedBody = utf8.decode(bodyBytes);
      return jsonDecode(decodedBody) as Map<String, dynamic>;
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(
        FundaApiUnExpectedResponse(error: e),
        stackTrace,
      );
    }
  }
}
