import 'dart:convert';
import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
//import 'package:retrofit/retrofit.dart';
//import 'package:dio/dio.dart' hide Headers;
//import 'dart:io';
//import 'package:http_parser/http_parser.dart' show MediaType;

part 'api_response.g.dart';


@JsonSerializable()
class APIResponse<T> {
  final String resultCode;
  final String resultMessage;
  @_Converter()
  final T data;

  APIResponse({this.resultCode, this.resultMessage, this.data});

  factory APIResponse.fromJson(Map<String, dynamic> json) => _$APIResponseFromJson(json);
  Map<String, dynamic> toJson() => _$APIResponseToJson(this);
}

class _Converter<T> implements JsonConverter<T, Object> {
  const _Converter();

  @override
  fromJson(Object json) {
    // if (T == LoginData) {
    //   return LoginData.fromJson(json) as T;
    // }
    
    return null;
  }

  @override
  Object toJson(T object) {
    return json.encode(object);
  }
}
