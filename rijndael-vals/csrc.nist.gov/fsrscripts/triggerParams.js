// Customer: NIST
// Version : DHTML Trigger 3.2.4
function cppUrlPatch(s) {
	var translated = "";
	var i; 
	var found = 0;
	for(i = 0; (found = s.indexOf(':', found)) != -1; ) {
		translated += s.substring(i, found) + "|";
		i = found + 1;
		found++;
	}
	translated += s.substring(i, s.length);
	return translated;
}
var triggerParms = new Array(); 
var excludeList = new Array();
var flashTagList= new Array();
triggerParms["displayMode"] = 1; //0=disable, 1=popup then dhtml, 2=popup only, 3=default dhtml only
triggerParms["mid"] = "EZAJ9hhQok8xZJZwMFIc4g=="; // model instance id
triggerParms["cid"] = "oK0Q08lXraBkX3paYPoUXQ=="; // customer id
triggerParms["lf"] = 3; // loyalty factor
triggerParms["sp"] = 25; // sample percentage
triggerParms["npc"] = 1; // no persistent cookies if 1
triggerParms["rw"] = 129600; // resample wait (value in minutes)
triggerParms["pu"] = 0; // pop-under control
triggerParms["olpu"] = 1; // On Load pop-under control
triggerParms["lfcookie"] = "ForeseeLoyalty_MID_EZAJ9hhQok";
triggerParms["ascookie"] = "ForeseeSurveyShown_EZAJ9hhQok";
triggerParms["width"] = 450; // survey width
triggerParms["height"] = 500; // survey height
triggerParms["domain"] = ".nist.gov"; // domain name
triggerParms["omb"] = "1505-0186"; // OMB number
//triggerParms["cmetrics"] = "90010257"; // coremetrics client id
triggerParms["visualScienceId"] = 0;	// enable visual science code if 1
triggerParms["omnitureId"] = 0;		// enable omniture code if 1
triggerParms["cpp_1"] = "userURL:" + cppUrlPatch (window.location.href);
//triggerParms["cpp_5"] = "cpp_name:"+ cppUrlPatch("cpp_value");	//a placeholder for customer CPP's
triggerParms["capturePageView"] = 1;
//excludeList[0] = "/exclude/"; //trigger script will not work under this path

//triggerParms["dcUniqueId"] = "TEST04JloZZN0k9cI1Ep5d"; //  (22 chars unique Id for double cookie I/II)
//triggerParms["midexp"] = 129600; // model instance expiry value
triggerParms["rso"]= 0; //user has chosen to use Retry Survey Option
triggerParms["aro"]= 0; //user has chosen to use Auto Retry Option, with SP=100
//triggerParms["rct"]= 1; //The maximum number of times allowed to serve a survey to a user
//triggerParms["rds"]= 1; //The minimum number of days to wait to serve a survey repeatedly
//triggerParms["mrd"]= 1; //The total number of days that a user can be re-served a survey

triggerParms["compliant508"] = 1; 	//508 compliant if 1

//DHTML Parameters
triggerParms["dhtmlIndex"]= 100;	// z-index s/b greater then client’s dhtml z-index (if exist) - default 100
triggerParms["dhtmlWidth"] = 400;	// welcome page width
triggerParms["dhtmlHeight"] = 290;	// welcome page height
triggerParms["dhtmlURL"]= "/fsrscripts/FSRInvite.html";

//DHTML Positioning
//center		bottom-center		bottom-right		bottom-left          upper-right           upper-left
//x,y = (2,150)		x,y = (2,350)		x,y = (1.02,350)	x,y = (60,350)     x,y = (1.02,50)     x,y = (60,50)
//replace (x,y) below with any one of the above, default = center

var x=2;
var y=150;

triggerParms["dhtmlLeft"] = (self.screen.width - triggerParms["dhtmlWidth"])/x;			//invite page left position**DO NOT MODIFY**
triggerParms["dhtmlTop"] = Math.min((self.screen.height - triggerParms["dhtmlHeight"])/2,y);	//invite page top position**DO NOT MODIFY**

//FLASH Parameters - not to be used with other embedded objects e.g. (.dcr/.mov/.mpeg/.avi/.wma/.wmv/.aam/.rm/.ram)
triggerParms["flashDetect"]= 0;		// check if page has flash embedded with a valid browser & player ver before showing  dhtml - disable if 0
flashTagList[0]= "swf";			// flash src check for IE/NE complaint browsers
flashTagList[1]= "spl";			// splash src check for IE/NE complaint browsers
flashTagList[2]= "clsid:d27cdb6e-ae6d-11cf-96b8-444553540000";	//activeX ID check for IE browsers only
triggerParms["inviteDelay"]= 1000;	// invite timeout in millisecs - default 1000ms=1sec

//List of Multiple Survey Vendors - uncomment variables below & add corresponding SP and URL
//var multiVendorSP= new Array();
//var multiVendorURL= new Array();
//multiVendorSP[0] = 0;		// sampling percentage for another vendor - disable if commented
//multiVendorURL[0] = "";	// absolute path to the third-party script - disable if commented

//Foresee System Paramters
triggerParms["captureTriggerVersion"] = "STD3.2.4";	// track latest trigger version
triggerParms["popupURL"] = "//www.foreseeresults.com/survey/display";	//do not change this url unless notified.
triggerParms["FSRImgURL"]= "//www.foreseeresults.com/survey/FSRImg"; 	//do not change this url unless notified.
