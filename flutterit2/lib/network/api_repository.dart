import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:flutterit2/globals.dart';
import 'package:flutterit2/models/api_response.dart';
/*
class ApiRepository {
  ApiRepository._internal() {
    this._dio = Dio()
      ..options.baseUrl = Globals().baseUrl
      ..options.connectTimeout = 30000
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options) {
            options.headers.addAll({'token': Globals().token});
            return options;
          },
          onResponse: (Response response) {
            APIResponse res = APIResponse.fromJson(response.data);
            if (res != null) {
              int resultCode = int.parse(res.resultCode);
              if (resultCode == ResultCode.TOKEN_EXPIRED) {
                //globalEvent.fire(TokenExpiredEvent());
                return null;
              }
            }
            return response;
          },
          onError: (DioError error) async {
            globalEvent.fire(CallingApiErrorEvent(message: error.message));
            return error;
          },
        ),
      );
    this._apiClient = ECabinetApiProvider(_dio);
  }
  static final ApiRepository _singleton = ApiRepository._internal();
  factory ApiRepository() {
    return _singleton;
  }

  ///dio safe http client
  Dio _dio;

  ///eCabinet api client
  ApiProvider _apiClient;

  void setToken(String token) {
    Globals().token = token;
    ApiRepository._internal();
  }

  void setDomain(String baseUrl) {
    this._dio.options.baseUrl = baseUrl;
  }

  Future<APIResponse<LoginData>> userLogin(String username, String password) {
    return _apiClient.login(username, password);
  }

  Future<APIResponse> changePassword(String oldPass, String newPass) {
    return _apiClient.changePassword(oldPass, newPass);
  }

  Future<APIResponse<AppInfo>> getAppInfo(String domain) {
    return _apiClient.getSystemInfoByDomain(domain);
  }

  Future<APIResponse<MeetingDocumentData>> getTaiLieuHop(int idLichHop) {
    return _apiClient.getTaiLieuHop(idLichHop);
  }

  Future<APIResponse<PersonalMeetingDocumentData>> getTaiLieuHopCaNhan(
      int idLichHop) {
    return _apiClient.getTaiLieuHopCaNhan(idLichHop);
  }

  Future<APIResponse> approveDocument(
      int idLichHop, int idTaiLieu, int duyet, String lyDo) {
    return _apiClient.setPheDuyet(idLichHop, idTaiLieu, duyet, lyDo);
  }

  Future<APIResponse> reApproveDocument(int fileID) {
    return _apiClient.guiPheDuyet(fileID);
  }

  Future<APIResponse> addComment(int idFile, String noiDung, {int nguoiNhan}) {
    if (nguoiNhan != null) {
      return _apiClient.setTraoDoi(idFile, noiDung, idNguoiNhan: nguoiNhan);
    }
    return _apiClient.setTraoDoi(idFile, noiDung);
  }

  Future<APIResponse<MeetingNoteData>> getMeetingNotes(int meetingID,
      {String searchText}) {
    return _apiClient.getDsGhiChu(meetingID, tuKhoa: searchText);
  }

  Future<APIResponse<MeetingListData>> getMeetingList() {
    return _apiClient.getDsLichThamGia();
  }

  Future<APIResponse> deleteMeetingNote(int noteID) {
    return _apiClient.deleteGhiChuCaNhan(noteID);
  }

  Future<APIResponse> addNewMeetingNote(int meetingID, String title,
      {String content}) {
    return _apiClient.addGhiChuCaNhan(meetingID, title, noiDung: content);
  }

  Future<APIResponse> updateMeetingNote(int noteID, String title,
      {String content}) {
    return _apiClient.updateGhiChuCaNhan(noteID, title, noiDung: content);
  }

  Future<APIResponse> sendMeetingNoteEmail(
      String ids, String email, String title, String content) {
    return _apiClient.sendEmailGhiChu(ids, email, title, content);
  }

  Future<APIResponse<ExportNoteData>> exportNoteData(int noteID) {
    return _apiClient.exportGhiChu(noteID);
  }

  Future<APIResponse<MeetingParticipant>> getDetailMetting(int idMetting) {
    return _apiClient.getDetailMetting(idMetting);
  }

  Future<APIResponse<MeetingResponse>> getUnitMeetingSchedule(
      MeetingFilterParam param) {
    return _apiClient.getUnitMeetingSchedule(
        param.tuan, param.thang, param.nam, param.type,
        ngay: param.ngay, timkiem: param.timkiem);
  }

  Future<APIResponse<MeetingResponse>> getPersonalMeetingSchedule(
      MeetingFilterParam param) {
    return _apiClient.getPersonalMeetingSchedule(
        param.tuan, param.thang, param.nam, param.type,
        ngay: param.ngay, timkiem: param.timkiem);
  }

  Future<APIResponse<NearestMeeting>> getNearestMeetingSchedule() {
    return _apiClient.getNearestMeetingSchedule();
  }

  Future<APIResponse<UnitDropdownResponse>> getWaitForConfirmUnit(
      int meetingID) {
    return _apiClient.getWaitForConfirmUnit(meetingID);
  }

  Future<APIResponse<MeetingResponse>> getWaitForConfirmSchedule(
      MeetingFilterParam param) {
    return _apiClient.getWaitForConfirmSchedule(
        param.tuan, param.thang, param.nam, param.type,
        ngay: param.ngay, timkiem: param.timkiem);
  }

  Future<APIResponse<String>> setAbsentReason(AbsentReason reason) {
    return _apiClient.setAbsentReason(reason.idLichHop, reason.lydo,
        idDonVi: reason.idDonVi);
  }

  Future<APIResponse<String>> delegateParticipant(
      MeetingParticipantDelegacy delegacy) {
    return _apiClient.delegateParticipant(
        delegacy.idLichHop, delegacy.idDonVi, delegacy.danhsachNhanVien);
  }

  Future<APIResponse<Object>> addPersonalSchedule(PersonalSchedule schedule) {
    return _apiClient.addPersonalSchedule(
        schedule.tieude,
        schedule.noidung,
        DateTimeUtils.datetimeAsString(
            schedule.thoigianBatDau, DateTimeParts.dateThenTime),
        DateTimeUtils.datetimeAsString(
            schedule.thoigianKetThuc, DateTimeParts.dateThenTime));
  }

  Future<APIResponse<Object>> editPersonalSchedule(PersonalSchedule schedule) {
    return _apiClient.editPersonalSchedule(
        schedule.id,
        schedule.tieude,
        schedule.noidung,
        DateTimeUtils.datetimeAsString(
            schedule.thoigianBatDau, DateTimeParts.dateThenTime),
        DateTimeUtils.datetimeAsString(
            schedule.thoigianKetThuc, DateTimeParts.dateThenTime));
  }

  Future<APIResponse<PersonalSchedule>> getPersonalSchedule(int scheduleId) {
    return _apiClient.getPersonalSchedule(scheduleId);
  }

  Future<APIResponse<Object>> deletePersonalSchedule(int scheduleId) {
    return _apiClient.deletePersonalSchedule(scheduleId);
  }

  Future<APIResponse<MeetingParticipantDetail>> getMeetingParticipant(
      int idMetting, String type) {
    return _apiClient.getMeetingParticipant(idMetting, type);
  }

  Future<APIResponse<DonViNhanVienResponse>> getCauTrucDonViNhanVien(
      int idDonVi) {
    return _apiClient.getCauTrucDonViNhanVien(idDonVi);
  }

  Future<APIResponse<MeetingParticipantAttend>> setMeetingParticipant(
      int idMetting, int userId, int thamdu) {
    return _apiClient.setMeetingParticipant(idMetting, userId, thamdu);
  }

  Future<APIResponse<PersonalFolderResponse>> getDSCayThuMucCaNhan() {
    return _apiClient.getDSCayThuMucCaNhan();
  }

  Future<APIResponse<PersonalFileResponse>> getDSTaiLieuCaNhan(int idFolder) {
    return _apiClient.getDSTaiLieuCaNhan(idFolder);
  }

  Future<APIResponse<Object>> addFolderCaNhan(
      int idFolderCha, String tenFolder) {
    return _apiClient.addFolderCaNhan(idFolderCha, tenFolder);
  }

  Future<APIResponse<Object>> deleteFolder(int idFolder) {
    return _apiClient.deleteFolder(idFolder);
  }

  Future<APIResponse<Object>> deletePersonalFile(int idFile) {
    return _apiClient.deleteFile(idFile);
  }

  Future<APIResponse<Object>> luuFileCaNhan(String idsFile, int idFolder) {
    return _apiClient.luuFileCaNhan(idsFile, idFolder);
  }

  Future<APIResponse<Object>> luuTaiLieuHopCaNhan(String idsFile, idLichHop) {
    return _apiClient.luuTaiLieuHopCaNhan(idsFile, idLichHop);
  }

  Future<APIResponse<Object>> deleteTaiLieuHopCaNhan(
      int idLichHop, int idTaiLieu) {
    return _apiClient.deleteTaiLieuHopCaNhan(idLichHop, idTaiLieu);
  }

  Future<APIResponse<PollsData>> getPollList(int meetingID) {
    return _apiClient.getDsLayYKien(meetingID);
  }

  Future<APIResponse> enablePoll(
      int meetingID, int pollID, String start, String stop) {
    return _apiClient.batDauBieuQuyet(pollID, meetingID, start, stop);
  }

  Future<APIResponse<PollDetailData>> getPollDetail(int pollID) {
    return _apiClient.layYKienBieuQuyet(pollID);
  }

  Future<APIResponse<PollDraftAnswerData>> getPollDetailDraft(int pollID) {
    return _apiClient.chiTietTraLoiLuuNhap(pollID);
  }

  Future<APIResponse<SendPollData>> sendPollData(
      int pollID, String status, SendAnswerData answerData) {
    return _apiClient.guiThongTinLayYKien(
        pollID, status, jsonEncode(answerData.answers));
  }

  Future<APIResponse<PollResultData>> getPollResult(int pollID, String type,
      {String departmentIDs, String employeeIDs}) {
    return _apiClient.ketQuaLayYKien(pollID, type,
        idsDonViThongKe: departmentIDs, idsNhanVienThongKe: employeeIDs);
  }

  Future<APIResponse<PollSignFileData>> signPollFile(int pollID) {
    return _apiClient.signFileLayYKien(pollID);
  }

  Future<APIResponse<MeetingConclusionData>> getDSKetLuanCuocHop(
      int idLichHop) {
    return _apiClient.getDSKetLuanCuocHop(idLichHop);
  }

  Future<APIResponse<MeetingConclusionReportData>> getDSBaoCaoCuocHop(
      int idLichHop) {
    return _apiClient.getDSBaoCaoCuocHop(idLichHop);
  }

  Future<APIResponse<UserData>> getUserData() {
    return _apiClient.getUserData();
  }

  Future<APIResponse> updateUserInfo(UserData user) {
    return _apiClient.suaThongTin(
        user.hoTen,
        user.diaChi,
        user.ngaySinh,
        user.gioiTinh,
        user.dienThoai,
        user.email,
        user.nhanSMSThongBao,
        user.nhanEmailThongBao,
        user.hinhThucKySo,
        fileAnhDaiDien: user.avatar,
        fileChuKy: user.signature);
  }

  Future<APIResponse<Object>> xoaTaiLieuHopCaNhan(int idTaiLieu) {
    return _apiClient.xoaTaiLieuHopCaNhan(idTaiLieu);
  }

  Future<APIResponse<Object>> dangKyPhatBieu(int idLichHop, String noiDung) {
    return _apiClient.dangKyPhatBieu(idLichHop, noiDung);
  }

  Future<APIResponse<CheckRegisteredSpeak>> kiemTraDangKyPhatBieu(
      int idLichHop) {
    return _apiClient.kiemTraDangKyPhatBieu(idLichHop);
  }

  Future<APIResponse> huyDangKyPhatBieu(int idLichHop) {
    return _apiClient.huyDangKyPhatBieu(idLichHop);
  }

  Future<APIResponse<Object>> signFile(int idFile) {
    return _apiClient.signFile(idFile);
  }

  Future<APIResponse<Object>> addFileCaNhan(int idFolder, String tenFile,
      UploadFileInfo file, ProgressCallback onSendProgress) async {
    final _data =
        FormData.from({'IDFolder': idFolder, 'TenFile': tenFile, 'File': file});
    final _result = await _dio.post('/api/mobile/file/addFileCaNhan',
        onSendProgress: (count, total) {
      onSendProgress(count, total);
    }, data: _data).then((result) {
      var value = APIResponse<Object>.fromJson(result.data);
      return Future.value(value);
    }).catchError((onError) {
      return Future.value(APIResponse<Object>(
          resultCode: '500', resultMessage: onError.toString()));
    });
    return _result;
  }

  Future<APIResponse<Object>> uploadTaiLieu(
      int idNhomTaiLieuHop,
      String tenFile,
      UploadFileInfo file,
      int taiLieuMat,
      String thoiGianTruyCap,
      String idsNhanVienTruyCap,
      String idsDonViTruyCap,
      ProgressCallback onSendProgress) async {
    final _data = FormData.from({
      'IDNhomTaiLieuHop': idNhomTaiLieuHop,
      'TenHienThi': tenFile,
      'TaiLieuMat': taiLieuMat,
      'ThoiGianTruyCap': thoiGianTruyCap,
      'IDsNhanVienTruyCap': idsNhanVienTruyCap,
      'IDsDonViTruyCap': idsDonViTruyCap,
      'File': file
    });
    final _result = await _dio.post('/api/mobile/thongtinlich/uploadTaiLieu',
        onSendProgress: (count, total) {
      onSendProgress(count, total);
    }, data: _data).then((result) {
      var value = APIResponse<Object>.fromJson(result.data);
      return Future.value(value);
    }).catchError((onError) {
      return Future.value(APIResponse<Object>(
          resultCode: '500', resultMessage: onError.toString()));
    });
    return _result;
  }

  Future<APIResponse<WebLinkData>> getDanhSachLienKetKhac() {
    return _apiClient.getDanhSachLienKetKhac();
  }

  Future<APIResponse<WaitingList>> danhSachChoPhatBieu(int idLichHop) {
    return _apiClient.danhSachChoPhatBieu(idLichHop);
  }

  Future<APIResponse> xacNhanPhatBieu(int idLichHop, int idNguoiPhatBieu) {
    return _apiClient.xacNhanPhatBieu(idLichHop, idNguoiPhatBieu);
  }

  void dispose() {
    this.dispose();
  }
}

class ResultCode {
  static const int SUCCESS = 0;
  static const int FAILED = -1;
  static const int TOKEN_EXPIRED = -2;
}

class CustomDioError extends DioError {
  @override
  String toString() {
    return (message ?? "") + (stackTrace ?? "").toString();
  }
}
*/