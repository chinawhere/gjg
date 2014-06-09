/*******************************************************************************
* KindEditor - WYSIWYG HTML Editor for Internet
* Copyright (C) 2006-2011 kindsoft.net
*
* @author Roddy <luolonghao@gmail.com>
* @site http://www.kindsoft.net/
* @licence http://www.kindsoft.net/license.php
*******************************************************************************/
KindEditor.plugin("map",function(e){var t=this,a="map",o=t.lang(a+".");t.clickToolbar(a,function(){function n(){s=c[0].contentWindow,i=e.iframeDoc(c)}var s,i,r=['<div style="padding:10px 20px;">','<div class="ke-dialog-row">',o.address+' <input id="kindeditor_plugin_map_address" name="address" class="ke-input-text" value="" style="width:200px;" /> ','<span class="ke-button-common ke-button-outer">','<input type="button" name="searchBtn" class="ke-button-common ke-button" value="'+o.search+'" />',"</span>","</div>",'<div class="ke-map" style="width:558px;height:360px;"></div>',"</div>"].join(""),l=t.createDialog({name:a,width:600,title:t.lang(a),body:r,yesBtn:{name:t.lang("yes"),click:function(){var e=(s.geocoder,s.map),a=e.getCenter().lat()+","+e.getCenter().lng(),o=e.getZoom(),n=e.getMapTypeId(),i="http://maps.googleapis.com/maps/api/staticmap";i+="?center="+encodeURIComponent(a),i+="&zoom="+encodeURIComponent(o),i+="&size=558x360",i+="&maptype="+encodeURIComponent(n),i+="&markers="+encodeURIComponent(a),i+="&language="+t.langType,i+="&sensor=false",t.exec("insertimage",i).hideDialog().focus()}},beforeRemove:function(){m.remove(),i&&i.write(""),c.remove()}}),d=l.div,p=e('[name="address"]',d),m=e('[name="searchBtn"]',d),c=(["<!doctype html><html><head>",'<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />',"<style>","	html { height: 100% }","	body { height: 100%; margin: 0; padding: 0; background-color: #FFF }","	#map_canvas { height: 100% }","</style>",'<script src="http://maps.googleapis.com/maps/api/js?sensor=false&language='+t.langType+'"></script>',"<script>","var map, geocoder;","function initialize() {","	var latlng = new google.maps.LatLng(31.230393, 121.473704);","	var options = {","		zoom: 11,","		center: latlng,","		disableDefaultUI: true,","		panControl: true,","		zoomControl: true,","		mapTypeControl: true,","		scaleControl: true,","		streetViewControl: false,","		overviewMapControl: true,","		mapTypeId: google.maps.MapTypeId.ROADMAP","	};",'	map = new google.maps.Map(document.getElementById("map_canvas"), options);',"	geocoder = new google.maps.Geocoder();","	geocoder.geocode({latLng: latlng}, function(results, status) {","		if (status == google.maps.GeocoderStatus.OK) {","			if (results[3]) {",'				parent.document.getElementById("kindeditor_plugin_map_address").value = results[3].formatted_address;',"			}","		}","	});","}","function search(address) {","	if (!map) return;","	geocoder.geocode({address : address}, function(results, status) {","		if (status == google.maps.GeocoderStatus.OK) {","			map.setZoom(11);","			map.setCenter(results[0].geometry.location);","			var marker = new google.maps.Marker({","				map: map,","				position: results[0].geometry.location","			});","		} else {",'			alert("Invalid address: " + address);',"		}","	});","}","</script>","</head>",'<body onload="initialize();">','<div id="map_canvas" style="width:100%; height:100%"></div>',"</body></html>"].join("\n"),e('<iframe class="ke-textarea" frameborder="0" src="'+t.pluginsPath+'map/map.html" style="width:558px;height:360px;"></iframe>'));c.bind("load",function(){c.unbind("load"),e.IE?n():setTimeout(n,0)}),e(".ke-map",d).replaceWith(c),m.click(function(){s.search(p.val())})})});