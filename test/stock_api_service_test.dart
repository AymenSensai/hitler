import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:stocks_app/core/networking/api_constants.dart';

void main() {
  final dio = Dio(BaseOptions());
  final dioAdapter = DioAdapter(dio: dio);

  // Mock response for getProducts
  final mockGetProductsResponse = {
    'message': 'Success',
    'data': [
      {
        'id': 1,
        'name': 'Product 1',
        'sku': 'P001',
        'stock': '100',
        'reorder_point': '20',
        'selling_price': '50.00',
        'cost_price': '30.00',
        'image': 'image_url',
        'category': {'id': 1, 'name': 'Category 1'},
        'orders': [],
      },
    ],
  };

  // Mock response for getContacts
  final mockGetContactsResponse = {
    'message': 'Success',
    'data': [
      {
        'id': 1,
        'name': 'Contact 1',
        'email': 'contact1@example.com',
        'phone': '1234567890',
      },
    ],
  };

  // Mock the GET request for products
  dioAdapter.onGet(
    ApiConstants.products,
    (server) {
      server.reply(
        200,
        mockGetProductsResponse,
        headers: {
          'content-type': ['application/json']
        },
      );
    },
  );

  // Mock the GET request for contacts
  dioAdapter.onGet(
    ApiConstants.contacts,
    (server) {
      server.reply(
        200,
        mockGetContactsResponse,
        headers: {
          'content-type': ['application/json']
        },
      );
    },
  );

  test('Test the mock response for getProducts', () async {
    final response = await dio.get(ApiConstants.products);

    expect(response.statusCode, 200);
    final responseData = response.data;
    expect(responseData['message'], 'Success');
    expect(responseData['data'], isNotEmpty);
    expect(responseData['data'][0]['name'], 'Product 1');
    expect(responseData['data'][0]['sku'], 'P001');
  });

  test('Test the mock response for getContacts', () async {
    final response = await dio.get(ApiConstants.contacts);

    expect(response.statusCode, 200);
    final responseData = response.data;
    expect(responseData['message'], 'Success');
    expect(responseData['data'], isNotEmpty);
    expect(responseData['data'][0]['name'], 'Contact 1');
    expect(responseData['data'][0]['phone'], '1234567890');
  });

  test('Test the mock response for product category name', () async {
    final response = await dio.get(ApiConstants.products);

    expect(response.statusCode, 200);
    final responseData = response.data;
    expect(responseData['message'], 'Success');
    expect(responseData['data'], isNotEmpty);
    expect(responseData['data'][0]['category']['name'], 'Category 1');
  });

  test('Test the mock response for product stock value', () async {
    final response = await dio.get(ApiConstants.products);

    expect(response.statusCode, 200);
    final responseData = response.data;
    expect(responseData['message'], 'Success');
    expect(responseData['data'], isNotEmpty);
    expect(responseData['data'][0]['stock'], '100');
  });

  test('Test the mock response for multiple products', () async {
    final mockMultipleProductsResponse = {
      'message': 'Success',
      'data': [
        {
          'id': 1,
          'name': 'Product 1',
          'sku': 'P001',
          'stock': '100',
          'reorder_point': '20',
          'selling_price': '50.00',
          'cost_price': '30.00',
          'image': 'image_url',
          'category': {'id': 1, 'name': 'Category 1'},
          'orders': [],
        },
        {
          'id': 2,
          'name': 'Product 2',
          'sku': 'P002',
          'stock': '200',
          'reorder_point': '40',
          'selling_price': '60.00',
          'cost_price': '40.00',
          'image': 'image_url',
          'category': {'id': 2, 'name': 'Category 2'},
          'orders': [],
        },
      ],
    };

    dioAdapter.onGet(
      ApiConstants.products,
      (server) {
        server.reply(200, mockMultipleProductsResponse);
      },
    );

    final response = await dio.get(ApiConstants.products);

    expect(response.statusCode, 200);
    final responseData = response.data;
    expect(responseData['message'], 'Success');
    expect(responseData['data'], isNotEmpty);
    expect(responseData['data'].length, 2);
  });

  test('Test the mock response for an incorrect status code', () async {
    dioAdapter.onGet(
      ApiConstants.products,
      (server) {
        server.reply(500, mockGetProductsResponse);
      },
    );

    final response = await dio.get(ApiConstants.products);

    expect(response.statusCode, 500);
  });

  test('Test the mock response for unexpected message value', () async {
    final incorrectResponse = {
      'message': 'Failure',
      'data': [],
    };

    dioAdapter.onGet(
      ApiConstants.products,
      (server) {
        server.reply(200, incorrectResponse);
      },
    );

    final response = await dio.get(ApiConstants.products);

    expect(response.statusCode, 200);
    final responseData = response.data;
    expect(responseData['message'], 'Success');
  });
}
