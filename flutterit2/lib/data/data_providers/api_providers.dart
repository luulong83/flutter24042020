import 'package:dio/dio.dart';
import 'package:flutterit2/models/models.dart';
import 'package:retrofit/http.dart';
import 'package:flutterit2/models/api_response.dart';

part 'api_providers.g.dart';

@RestApi()
abstract class APIProvider {
  factory APIProvider(Dio dio) = _ApiProvider;

  @POST("/api/mobile/account/login")
  Future<APIResponse<LoginData>> login(@Field() String username, @Field() String password);
}
