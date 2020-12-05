import 'package:uuid/uuid.dart';

class SiteVisit{
  String entryuid;
  String siteId;
  DateTime dateofVisit;
  var dgCapacity;
  var genRH;
  var lastPPM;
  bool dgDuePPM;
  var freq;
  var dgACVolts;
  var dgACLoad;
  bool engOilOk;
  bool radOk;
  var dieselDipLts;
  var dieselDipcm;
  var dieselGal;
  bool phcnOk;
  bool hybridOk;
  var dcLoad;
  var moduleNo;
  int secLtOk;
  int avLtOk; //0 is na, 1 ok, 2 not ok
  bool janitOk;
  String comment;
  bool pending;

SiteVisit(){
  this.entryuid = Uuid().v1();
}
  save(){
    print("here");
  }

  Map<String, dynamic> toMap() {
    return {
      'entryuid' :entryuid,
      'siteId' : siteId,
      'dateofVisit' : dateofVisit.toIso8601String(),
      'dgCapacity' :dgCapacity,
      'genRH' : genRH,
   'lastPPM': lastPPM,
   'dgDuePPM': dgDuePPM ?1:0,
   'freq': freq,
   'dgACVolts': dgACVolts,
   'dgACLoad': dgACLoad,
   'engOilOk': engOilOk ?1:0,
   'radOk': radOk ?1:0,
   'dieselDipLts': dieselDipLts,
   'dieselDipcm': dieselDipcm,
   'dieselGal': dieselGal,
   'phcnOk': phcnOk ?1:0,
   'hybridOk': hybridOk ?1:0,
   'dcLoad': dcLoad,
   'moduleNo': moduleNo,
   'secLtOk': secLtOk,
   'avLtOk':avLtOk,
   'janitOk':janitOk ?1:0,
   'comment':comment,
   'pending': pending? 1:0
    };
  }

  Map<String, dynamic> toMapSm() {
    return {
      'entryuid' :entryuid,
      'siteId' : siteId,
      'dateofVisit' : dateofVisit.toIso8601String(),
      'dgCapacity' :dgCapacity,
      'genRH' : genRH,
   'lastPPM': lastPPM,
   'dgDuePPM': dgDuePPM ?1:0,
    'freq': freq,
   'dgACVolts': dgACVolts,
   'dgACLoad': dgACLoad,
   'engOilOk': engOilOk ?1:0,
   'radOk': radOk ?1:0,
   'dieselDipLts': dieselDipLts,
   'dieselDipcm': dieselDipcm,
   'dieselGal': dieselGal,
   'phcnOk': phcnOk ?1:0,
   'hybridOk': hybridOk ?1:0,
   'dcLoad': dcLoad,
   'moduleNo': moduleNo,
   'secLtOk': secLtOk,
   'avLtOk':avLtOk,
   'janitOk':janitOk ?1:0
    };
  }

  static SiteVisit fromMap(Map<String, dynamic> visit){
     SiteVisit visitObj = SiteVisit();
     visitObj.entryuid = visit['entryuid'];
      visitObj.siteId = visit['siteId'];
      visitObj.dateofVisit = DateTime.tryParse( visit['dateofVisit']);
      visitObj.dgCapacity = visit['dgCapacity'];
      visitObj.genRH = visit['genRH'];
      visitObj.lastPPM = visit['lastPPM']; 
      visitObj.dgDuePPM = visit['dgDuePPM'] == 1 ?true:false;
      visitObj.freq = visit['freq'];
      visitObj.dgACVolts = visit['dgACVolts'];
      visitObj.dgACLoad = visit['dgACLoad'];
      visitObj.engOilOk = visit['engOilOk'] == 1 ?true:false;
      visitObj.radOk = visit['radOk']== 1 ?true:false;
      visitObj.dieselDipLts = visit['dieselDipLts'];
      visitObj.dieselDipcm = visit['dieselDipcm'];
      visitObj.dieselGal = visit['dieselGal'];
      visitObj.phcnOk = visit['phcnOk']== 1 ?true:false;
      visitObj.hybridOk = visit['hybridOk']== 1 ?true:false;
      visitObj.dcLoad = visit['dcLoad'];
      visitObj.moduleNo = visit['moduleNo'];
      visitObj.secLtOk = visit['secLtOk'] ;
      visitObj.avLtOk = visit['avLtOk'];
      visitObj.janitOk = visit['janitOk']== 1 ?true:false;
      visitObj.comment = visit['comment'];
      visitObj.pending = visit['pending']== 1 ?true:false;
      return visitObj; 
       }

      static SiteVisit fromMapSm(Map<String, dynamic> visit){
     SiteVisit visitObj = SiteVisit();
     visitObj.entryuid = visit['entryuid'];
      visitObj.siteId = visit['siteId'];
      visitObj.dateofVisit = DateTime.tryParse( visit['dateofVisit']);
      visitObj.dgCapacity = visit['dgCapacity'];
      visitObj.genRH = visit['genRH'];
      visitObj.lastPPM = visit['lastPPM']; 
      visitObj.dgDuePPM = visit['dgDuePPM'] == 1 ?true:false;
      visitObj.freq = visit['freq'];
      visitObj.dgACVolts = visit['dgACVolts'];
      visitObj.dgACLoad = visit['dgACLoad'];
      visitObj.engOilOk = visit['engOilOk'] == 1 ?true:false;
      visitObj.radOk = visit['radOk']== 1 ?true:false;
      visitObj.dieselDipLts = visit['dieselDipLts'];
      visitObj.dieselDipcm = visit['dieselDipcm'];
      visitObj.dieselGal = visit['dieselGal'];
      visitObj.phcnOk = visit['phcnOk']== 1 ?true:false;
      visitObj.hybridOk = visit['hybridOk']== 1 ?true:false;
      visitObj.dcLoad = visit['dcLoad'];
      visitObj.moduleNo = visit['moduleNo'];
      visitObj.secLtOk = visit['secLtOk'] ;
      visitObj.avLtOk = visit['avLtOk'];
      visitObj.janitOk = visit['janitOk']== 1 ?true:false;
      
      return visitObj; 
       } 

       static SiteVisit fromList(List< dynamic> visit){
     SiteVisit visitObj = SiteVisit();
     visitObj.entryuid = visit[0];
      visitObj.siteId = visit[1];
      visitObj.dateofVisit = DateTime.tryParse(visit[2]);
      visitObj.dgCapacity = visit[3];
      visitObj.genRH = visit[4];
      visitObj.lastPPM = visit[5]; 
      visitObj.dgDuePPM = visit[6]== 1 ?true:false;
      visitObj.freq = visit[7];
      visitObj.dgACVolts = visit[8];
      visitObj.dgACLoad = visit[9];
      visitObj.engOilOk = visit[10]== 1 ?true:false;
      visitObj.radOk = visit[11]== 1 ?true:false;
      visitObj.dieselDipLts = visit[12];
      visitObj.dieselDipcm = visit[13];
      visitObj.dieselGal = visit[14];
      visitObj.phcnOk = visit[15]== 1 ?true:false;
      visitObj.hybridOk = visit[16]== 1 ?true:false;
      visitObj.dcLoad = visit[17];
      visitObj.moduleNo = visit[18];
      visitObj.secLtOk = visit[19];
      visitObj.avLtOk = visit[20];
      visitObj.janitOk = visit[21]== 1 ?true:false;
      visitObj.comment = visit[22];
      visitObj.pending = visit[23]==1 ? true:false;
      return visitObj;
       }
       
  
}

