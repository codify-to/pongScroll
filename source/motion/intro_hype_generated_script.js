//	HYPE.documents["intro"]

(function HYPE_DocumentLoader() {
	var resourcesFolderName = "intro_Resources";
	var documentName = "intro";
	var documentLoaderFilename = "intro_hype_generated_script.js";

	// find the URL for this script's absolute path and set as the resourceFolderName
	try {
		var scripts = document.getElementsByTagName('script');
		for(var i = 0; i < scripts.length; i++) {
			var scriptSrc = scripts[i].src;
			if(scriptSrc != null && scriptSrc.indexOf(documentLoaderFilename) != -1) {
				resourcesFolderName = scriptSrc.substr(0, scriptSrc.lastIndexOf("/"));
				break;
			}
		}
	} catch(err) {	}

	// Legacy support
	if (typeof window.HYPE_DocumentsToLoad == "undefined") {
		window.HYPE_DocumentsToLoad = new Array();
	}
 
	// load HYPE.js if it hasn't been loaded yet
	if(typeof HYPE_124 == "undefined") {
		if(typeof window.HYPE_124_DocumentsToLoad == "undefined") {
			window.HYPE_124_DocumentsToLoad = new Array();
			window.HYPE_124_DocumentsToLoad.push(HYPE_DocumentLoader);

			var headElement = document.getElementsByTagName('head')[0];
			var scriptElement = document.createElement('script');
			scriptElement.type= 'text/javascript';
			scriptElement.src = resourcesFolderName + '/' + 'HYPE.js?hype_version=124';
			headElement.appendChild(scriptElement);
		} else {
			window.HYPE_124_DocumentsToLoad.push(HYPE_DocumentLoader);
		}
		return;
	}
	
	// guard against loading multiple times
	if(HYPE.documents[documentName] != null) {
		return;
	}
	
	var hypeDoc = new HYPE_124();
	
	var attributeTransformerMapping = {b:"i",c:"i",bC:"i",d:"i",aS:"i",M:"i",e:"f",N:"i",f:"d",aT:"i",O:"i",g:"c",aU:"i",P:"i",Q:"i",aV:"i",R:"c",aW:"f",S:"i",aI:"i",T:"i",l:"d",aX:"i",aJ:"i",m:"c",n:"c",aK:"i",aZ:"i",X:"i",A:"c",Y:"i",aL:"i",B:"c",C:"c",D:"c",t:"i",E:"i",G:"c",bA:"c",a:"i",bB:"i"};

var scenes = [{onSceneAnimationCompleteAction:{type:4,javascriptOid:"19"},timelines:{kTimelineDefaultIdentifier:{framesPerSecond:30,animations:[{f:"4",t:0,d:0.83333331,i:"a",e:-213,r:1,s:-300,o:"2"},{f:"4",t:0,d:0.83333331,i:"b",e:-162,r:1,s:-165,o:"2"},{f:"0",t:0,d:0.1,i:"e",e:"1.000000",r:1,s:"0.000000",o:"9"},{f:"0",t:0.1,d:0.06666667,i:"e",e:"0.320000",s:"1.000000",o:"9"},{f:"0",t:0.16666667,d:0.066666663,i:"e",e:"1.000000",s:"0.320000",o:"9"},{f:"0",t:0.23333333,d:0.13333334,i:"e",e:"0.540000",s:"1.000000",o:"9"},{f:"0",t:0.36666667,d:0.099999994,i:"e",e:"1.000000",s:"0.540000",o:"9"},{f:"4",t:0.46666667,d:0.20000002,i:"e",e:"1.000000",r:1,s:"0.000000",o:"7"},{f:"1",t:0.46666667,d:0.60000002,i:"b",e:144,r:1,s:47,o:"7"},{f:"4",t:0.46666667,d:0.20000002,i:"e",e:"1.000000",r:1,s:"0.000000",o:"8"},{f:"1",t:0.46666667,d:0.49999997,i:"b",e:29,r:1,s:131,o:"8"},{f:"1",t:0.46666667,d:0.36666664,i:"a",e:261,r:1,s:198,o:"9"},{f:"1",t:0.46666667,d:0.36666664,i:"b",e:88,r:1,s:135,o:"9"},{f:"1",t:0.46666667,d:1.6333332,i:"e",e:"1.000000",s:"1.000000",o:"9"},{f:"1",t:0.66666669,d:1.4666667,i:"e",e:"1.000000",s:"1.000000",o:"7"},{f:"1",t:0.66666669,d:1.4333332,i:"e",e:"1.000000",s:"1.000000",o:"8"},{f:"1",t:0.83333331,d:0.36666673,i:"a",e:142,s:261,o:"9"},{f:"1",t:0.83333331,d:0.36666673,i:"b",e:145,s:88,o:"9"},{f:"1",t:0.96666664,d:0.59999996,i:"b",e:131,s:29,o:"8"},{f:"4",t:1.0666667,d:0.5666666,i:"b",e:47,s:144,o:"7"},{f:"1",t:1.2,d:0.43333328,i:"a",e:261,s:142,o:"9"},{f:"1",t:1.2,d:0.43333328,i:"b",e:200,s:145,o:"9"},{f:"1",t:1.5666666,d:0.60000014,i:"b",e:43,s:131,o:"8"},{f:"1",t:1.6333333,d:0.63333333,i:"b",e:151,s:47,o:"7"},{f:"1",t:1.6333333,d:0.50000012,i:"a",e:142,s:261,o:"9"},{f:"1",t:1.6333333,d:0.50000012,i:"b",e:57,s:200,o:"9"},{f:"1",t:2.0999999,d:0.4333334,i:"e",e:"0.000000",s:"1.000000",o:"8"},{f:"1",t:2.0999999,d:0.33333349,i:"e",e:"0.000000",s:"1.000000",o:"9"},{f:"1",t:2.1333334,d:0.43333316,i:"e",e:"0.000000",s:"1.000000",o:"7"},{f:"1",t:2.1333334,d:0.5333333,i:"a",e:261,s:142,o:"9"},{f:"1",t:2.1333334,d:0.5333333,i:"b",e:83,s:57,o:"9"},{f:"1",t:2.1666667,d:0.5666666,i:"b",e:131,s:43,o:"8"},{f:"4",t:2.2666667,d:0.5,i:"b",e:47,s:151,o:"7"}],identifier:"kTimelineDefaultIdentifier",name:"Main Timeline",duration:2.7666667}},sceneIndex:0,perspective:"600px",initialValues:{"8":{o:"content-box",h:"barRight.jpg",x:"visible",a:458,q:"100% 100%",b:131,j:"absolute",r:"inline",c:37,z:"3",k:"div",d:233,e:"0.000000"},"9":{o:"content-box",h:"logoPong.jpg",x:"visible",a:198,q:"100% 100%",b:135,j:"absolute",r:"inline",c:197,z:"4",k:"div",d:198,e:"0.000000"},"7":{o:"content-box",h:"barLeft.jpg",x:"visible",a:105,q:"100% 100%",b:47,j:"absolute",r:"inline",c:37,z:"2",k:"div",d:233,e:"0.000000"},"2":{o:"content-box",h:"scrollpong_intro.jpg",x:"visible",a:-300,q:"100% 100%",b:-165,j:"absolute",r:"none",c:1200,k:"div",z:"1",d:794}},oid:"1",backgroundColor:"#FFFFFF",name:"intro"},{timelines:{kTimelineDefaultIdentifier:{framesPerSecond:30,animations:[{f:"2",t:0,d:0.16666667,i:"e",e:"1.000000",r:1,s:"0.000000",o:"21"},{f:"2",t:0,d:0.16666667,i:"d",e:156,r:1,s:84,o:"21"},{f:"2",t:0,d:0.16666667,i:"a",e:218,r:1,s:300,o:"21"},{f:"2",t:0,d:0.16666667,i:"b",e:166,r:1,s:202,o:"21"},{f:"2",t:0,d:0.16666667,i:"c",e:353,r:1,s:189,o:"21"},{f:"2",t:0.16666667,d:0.16666667,i:"d",e:132,s:156,o:"21"},{f:"2",t:0.16666667,d:0.16666667,i:"a",e:245,s:218,o:"21"},{f:"2",t:0.16666667,d:0.16666667,i:"b",e:178,s:166,o:"21"},{f:"2",t:0.16666667,d:0.16666667,i:"c",e:299,s:353,o:"21"},{f:"4",t:0.2,d:0.10000001,i:"e",e:"1.000000",r:1,s:"0.000000",o:"31"},{f:"2",t:0.23333333,d:0.26666665,i:"c",e:237,r:1,s:12,o:"25"},{f:"2",t:0.23333333,d:0.26666665,i:"b",e:19,r:1,s:198,o:"25"},{f:"2",t:0.23333333,d:0.26666665,i:"a",e:42,r:1,s:265,o:"25"},{f:"2",t:0.23333333,d:0.26666665,i:"f",e:"0deg",r:1,s:"73deg",o:"25"},{f:"2",t:0.23333333,d:0.26666665,i:"d",e:192,r:1,s:10,o:"25"},{f:"2",t:0.23333333,d:0.10000001,i:"e",e:"1.000000",r:1,s:"0.000000",o:"25"},{f:"2",t:0.5,d:0.23333335,i:"c",e:217,s:237,o:"25"},{f:"2",t:0.5,d:0.23333335,i:"b",e:34,s:19,o:"25"},{f:"2",t:0.5,d:0.23333335,i:"a",e:61,s:42,o:"25"},{f:"2",t:0.5,d:0.23333335,i:"d",e:176,s:192,o:"25"},{f:"4",t:1.2,d:0.16666663,i:"a",e:373,r:1,s:344,o:"23"},{f:"4",t:1.2,d:0.099999905,i:"e",e:"1.000000",r:1,s:"0.000000",o:"23"},{f:"2",t:1.3666667,d:0.23333335,i:"b",e:343,r:1,s:359,o:"27"},{f:"2",t:1.3666667,d:0.10000002,i:"e",e:"1.000000",r:1,s:"0.000000",o:"27"},{f:"4",t:1.6,d:0.16666663,i:"a",e:373,r:1,s:343,o:"26"},{f:"4",t:1.6,d:0.10000002,i:"e",e:"1.000000",r:1,s:"0.000000",o:"26"},{f:"2",t:1.7666667,d:0.10000002,i:"e",e:"1.000000",r:1,s:"0.000000",o:"24"},{f:"2",t:1.7666667,d:0.23333335,i:"b",e:375,r:1,s:365,o:"24"}],identifier:"kTimelineDefaultIdentifier",name:"Main Timeline",duration:2}},sceneIndex:1,onSceneKeyUpAction:{type:0},perspective:"600px",initialValues:{"26":{o:"content-box",w:"",h:"icoFb.jpg",x:"visible",a:343,q:"100% 100%",b:375,j:"absolute",r:"inline",aA:{type:4,javascriptOid:"30"},c:22,z:"6",d:20,k:"div",t:17,e:"0.000000",aP:"pointer"},"21":{o:"content-box",h:"boxPoints.jpg",x:"visible",a:300,q:"100% 100%",b:202,j:"absolute",r:"inline",c:189,z:"2",k:"div",d:84,e:"0.000000"},"24":{o:"content-box",h:"txt_share.png",x:"visible",a:399,q:"100% 100%",b:365,j:"absolute",r:"inline",aA:{type:4,javascriptOid:"30"},c:90,z:"7",d:20,k:"div",e:"0.000000",aP:"pointer"},"27":{o:"content-box",h:"txtPlayAgain.png",x:"visible",a:399,q:"100% 100%",b:359,j:"absolute",r:"inline",aA:{type:4,javascriptOid:"29"},c:160,z:"5",d:20,k:"div",e:"0.000000",aP:"pointer"},"22":{o:"content-box",h:"scrollpong_gameover.jpg",x:"visible",a:-183,q:"100% 100%",b:-182,j:"absolute",r:"none",c:1200,k:"div",z:"1",d:794},"25":{o:"content-box",h:"gameOver.png",p:"no-repeat",x:"visible",a:265,q:"100% 100%",b:198,j:"absolute",r:"inline",c:12,z:"3",k:"div",d:10,aY:"0",e:"0.000000",f:"73deg"},"23":{o:"content-box",h:"ico_playAgain.jpg",x:"visible",a:344,q:"100% 100%",b:342,j:"absolute",r:"inline",aA:{type:4,javascriptOid:"29"},c:22,z:"4",d:20,k:"div",e:"0.000000",aP:"pointer"},"31":{aU:0,G:"#000000",c:134,aV:0,r:"inline",d:40,e:"0.000000",X:-1,t:25,Y:0,aX:0,Z:"break-word",i:"animScore",w:"New Text",j:"absolute",x:"visible",k:"div",y:"preserve",z:"8",aS:0,aT:0,a:401,b:237}},oid:"28",backgroundColor:"#FFFFFF",name:"game over"}];


	
	var javascripts = [{name:"introComplete",source:"function(hypeDocument, element, event) {\n\tinitGame();\n\t\n\t\n}",identifier:"19"},{name:"playAgain",source:"function(hypeDocument, element, event) {\n\tgame.playAgain();\n\t\n}",identifier:"29"},{name:"fbShare",source:"function(hypeDocument, element, event) {\n\twindow.fbShare();\n\t\n\t\n}",identifier:"30"}];


	
	var Custom = {};
	var javascriptMapping = {};
	for(var i = 0; i < javascripts.length; i++) {
		try {
			javascriptMapping[javascripts[i].identifier] = javascripts[i].name;
			eval("Custom." + javascripts[i].name + " = " + javascripts[i].source);
		} catch (e) {
			hypeDoc.log(e);
			Custom[javascripts[i].name] = (function () {});
		}
	}
	
	hypeDoc.setAttributeTransformerMapping(attributeTransformerMapping);
	hypeDoc.setScenes(scenes);
	hypeDoc.setJavascriptMapping(javascriptMapping);
	hypeDoc.Custom = Custom;
	hypeDoc.setCurrentSceneIndex(0);
	hypeDoc.setMainContentContainerID("intro_hype_container");
	hypeDoc.setResourcesFolderName(resourcesFolderName);
	hypeDoc.setShowHypeBuiltWatermark(0);
	hypeDoc.setShowLoadingPage(false);
	hypeDoc.setDrawSceneBackgrounds(true);
	hypeDoc.setDocumentName(documentName);

	HYPE.documents[documentName] = hypeDoc.API;

	hypeDoc.documentLoad(this.body);
}());

