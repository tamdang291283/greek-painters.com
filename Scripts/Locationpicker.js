/**
 *
 * A JQUERY GOOGLE MAPS LATITUDE AND LONGITUDE LOCATION PICKER
 * version 1.2
 *
 * Supports multiple maps. Works on touchscreen. Easy to customize markup and CSS.
 *
 * To see a live demo, go to:
 * http://www.wimagguc.com/projects/jquery-latitude-longitude-picker-gmaps/
 *
 * by Richard Dancsi
 * http://www.wimagguc.com/
 *
 */

(function($) {

// for ie9 doesn't support debug console >>>
if (!window.console) window.console = {};
if (!window.console.log) window.console.log = function () { };
// ^^^

$.fn.gMapsLatLonPicker = (function() {

	var _self = this;

	///////////////////////////////////////////////////////////////////////////////////////////////
	// PARAMETERS (MODIFY THIS PART) //////////////////////////////////////////////////////////////
	_self.params = {
		defLat : 0,
		defLng : 0,
		defZoom : 1,
		queryLocationNameWhenLatLngChanges: true,
		queryElevationWhenLatLngChanges: true,
		mapOptions : {
			mapTypeId: google.maps.MapTypeId.ROADMAP,
			mapTypeControl: false,
			disableDoubleClickZoom: true,
			zoomControlOptions: true,
			streetViewControl: false
		},
		strings : {
			markerText : "Drag this Marker",
			error_empty_field : "Couldn't find coordinates for this place",
			error_no_results : "Couldn't find coordinates for this place"
		}
	};


	///////////////////////////////////////////////////////////////////////////////////////////////
	// VARIABLES USED BY THE FUNCTION (DON'T MODIFY THIS PART) ////////////////////////////////////
	_self.vars = {
		ID : null,
		LATLNG : null,
		map : null,
		marker : null,
		geocoder : null
	};

	///////////////////////////////////////////////////////////////////////////////////////////////
	// PRIVATE FUNCTIONS FOR MANIPULATING DATA ////////////////////////////////////////////////////
	var setPosition = function(position) {
		_self.vars.marker.setPosition(position);
		//_self.vars.map.panTo(position);
		_self.vars.map.setCenter(position);

		$(_self.vars.cssID + ".gllpZoom").val( _self.vars.map.getZoom() );
		$(_self.vars.cssID + ".gllpLongitude").val( position.lng() );
		$(_self.vars.cssID + ".gllpLatitude").val( position.lat() );

		$(_self.vars.cssID).trigger("location_changed", $(_self.vars.cssID));

		var latlng = new google.maps.LatLng(position.lat(), position.lng());
		_self.vars.geocoder.geocode({ 'latLng': latlng }, function (results, status) {
		    if (status == google.maps.GeocoderStatus.OK && results[0]) {
		        $("#spnLocationAddress").html(results[0].formatted_address + " [" + results[0].geometry.location.lat() + "," + results[0].geometry.location.lng() + "]");
		        
		        var tempStreetNumber = '', tempRouteName = '', tempLocalcity= '';
		        tempStreetNumber = '';
                for (i = 0; i < results[0].address_components.length; i++)
		        {
		            if (results[0].address_components[i].types[0] == "postal_code") {
		                $("#hidPostCode").val(results[0].address_components[i].short_name);		                
		            }
		            else if (results[0].address_components[i].types[0] == "street_number") {
		                tempStreetNumber = results[0].address_components[i].short_name + ' ';
		            }
		            else if (results[0].address_components[i].types[0] == "route") {
		                tempRouteName = results[0].address_components[i].short_name;
		            }
		            else if (results[0].address_components[i].types[0] == "locality") {
		                tempLocalcity = results[0].address_components[i].short_name;
		            }
		            else if (results[0].address_components[i].types[0] == "postal_town") {
		                tempLocalcity = results[0].address_components[i].short_name;
		            }
                }
                // Update issue 159
                if (typeof results[0].formatted_address != "undefined") {
                 $("#hidFormattedAdd").val(results[0].formatted_address);
                } else {
                    if (tempRouteName != '') {
                        if (tempStreetNumber != '')
                            $("#hidFormattedAdd").val(tempStreetNumber + '[*]' + tempRouteName + '[*]' + tempLocalcity);
                        else
                            $("#hidFormattedAdd").val(tempRouteName + '[*]' + tempLocalcity);
                    }
                    else $("#hidFormattedAdd").val(tempLocalcity);
                    // $(_self.vars.cssID + ".gllpLocationName").val(results[1].formatted_address);
                }
                // end
		    } else {
		        $("#spnLocationAddress").html("");
		    }
		    
		});

		if (_self.params.queryLocationNameWhenLatLngChanges) {
			getLocationName(position);
		}
		if (_self.params.queryElevationWhenLatLngChanges) {
			getElevation(position);
		}
	};

	// for reverse geocoding
	var getLocationName = function(position) {
		var latlng = new google.maps.LatLng(position.lat(), position.lng());
		_self.vars.geocoder.geocode({'latLng': latlng}, function(results, status) {
			if (status == google.maps.GeocoderStatus.OK && results[1]) {
				$(_self.vars.cssID + ".gllpLocationName").val(results[1].formatted_address);
			} else {
				$(_self.vars.cssID + ".gllpLocationName").val("");
			}
			$(_self.vars.cssID).trigger("location_name_changed", $(_self.vars.cssID));
		});
	};

	// for getting the elevation value for a position
	var getElevation = function(position) {
		var latlng = new google.maps.LatLng(position.lat(), position.lng());

		var locations = [latlng];

		var positionalRequest = { 'locations': locations };

		_self.vars.elevator.getElevationForLocations(positionalRequest, function(results, status) {
			if (status == google.maps.ElevationStatus.OK) {
				if (results[0]) {
					$(_self.vars.cssID + ".gllpElevation").val( results[0].elevation.toFixed(3));
				} else {
					$(_self.vars.cssID + ".gllpElevation").val("");
				}
			} else {
				$(_self.vars.cssID + ".gllpElevation").val("");
			}
			$(_self.vars.cssID).trigger("elevation_changed", $(_self.vars.cssID));
		});
	};

	// search function
	var performSearch = function(string, silent) {
		if (string == "") {
			if (!silent) {
				displayError( _self.params.strings.error_empty_field );
			}
			return;
		}
		_self.vars.geocoder.geocode(
			{"address": string},
			function(results, status) {
				if (status == google.maps.GeocoderStatus.OK) {
					$(_self.vars.cssID + ".gllpZoom").val(16);
					_self.vars.map.setZoom( parseInt($(_self.vars.cssID + ".gllpZoom").val()) );
					setPosition(results[0].geometry.location);
					
				} else {
					if (!silent) {
						displayError( _self.params.strings.error_no_results );
					}
				}
			}
		);
	};

	// error function
	var displayError = function(message) {
		alert(message);
	};
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	// PUBLIC FUNCTIONS  //////////////////////////////////////////////////////////////////////////
	var publicfunc = {

		// INITIALIZE MAP ON DIV //////////////////////////////////////////////////////////////////
	    init : function(object) {

	        if ( !$(object).attr("id") ) {
	            if ( $(object).attr("name") ) {
	                $(object).attr("id", $(object).attr("name") );
	            } else {
	                $(object).attr("id", "_MAP_" + Math.ceil(Math.random() * 10000) );
	            }
	        }

	        _self.vars.ID = $(object).attr("id");
	        _self.vars.cssID = "#" + _self.vars.ID + " ";

	        
	    
			_self.params.defLat  = $(_self.vars.cssID + ".gllpLatitude").val()  ? $(_self.vars.cssID + ".gllpLatitude").val()		: _self.params.defLat;
			_self.params.defLng  = $(_self.vars.cssID + ".gllpLongitude").val() ? $(_self.vars.cssID + ".gllpLongitude").val()	    : _self.params.defLng;
			_self.params.defZoom = $(_self.vars.cssID + ".gllpZoom").val()      ? parseInt($(_self.vars.cssID + ".gllpZoom").val()) : _self.params.defZoom;

			_self.vars.LATLNG = new google.maps.LatLng(_self.params.defLat, _self.params.defLng);

			_self.vars.MAPOPTIONS		 = _self.params.mapOptions;
			_self.vars.MAPOPTIONS.zoom   = _self.params.defZoom;
			_self.vars.MAPOPTIONS.center = _self.vars.LATLNG;

			_self.vars.map = new google.maps.Map($(_self.vars.cssID + ".gllpMap").get(0), _self.vars.MAPOPTIONS);
			_self.vars.geocoder = new google.maps.Geocoder();
			_self.vars.elevator = new google.maps.ElevationService();

            

			var pinIcon = new google.maps.MarkerImage(
                imagegooglemarker,
                null, /* size is determined at runtime */
                null, /* origin is 0,0 */
                null, /* anchor is bottom center of the scaled image */
                new google.maps.Size(42, 68)
            );

			_self.vars.marker = new google.maps.Marker({
				position: _self.vars.LATLNG,
				map: _self.vars.map,
				title: _self.params.strings.markerText,
				
				draggable: true
			});
			_self.vars.marker.setIcon(pinIcon);

			console.log("Current Lat, Long:" + curLat + "," + curLng);

			if (curLat != 20 && curLng != 20) {
			    //Handle set current location
			    $(_self.vars.cssID + ".gllpLatitude").val(curLat);
			    $(_self.vars.cssID + ".gllpLongitude").val(curLng);
			    $(_self.vars.cssID + ".gllpZoom").val("16");
			    _self.vars.LATLNG = new google.maps.LatLng(curLat, curLng);

			    setPosition(_self.vars.LATLNG);
			    _self.vars.map.setZoom(16);
			}

			var infowindow = new google.maps.InfoWindow({
			    content: "Move the marker as needed to select your location"
			});
			infowindow.open(_self.vars.map, _self.vars.marker);


			// Set position on doubleclick
			google.maps.event.addListener(_self.vars.map, 'dblclick', function(event) {
				setPosition(event.latLng);
			});

			// Set position on marker move
			google.maps.event.addListener(_self.vars.marker, 'dragend', function(event) {
				setPosition(_self.vars.marker.position);
			});

			// Set zoom feld's value when user changes zoom on the map
			google.maps.event.addListener(_self.vars.map, 'zoom_changed', function(event) {
				$(_self.vars.cssID + ".gllpZoom").val( _self.vars.map.getZoom() );
				$(_self.vars.cssID).trigger("location_changed", $(_self.vars.cssID));
			});

		    // Set responsive map
			
			google.maps.event.addDomListener(window, "resize", function () {
			    var center = _self.vars.map.getCenter();
			    google.maps.event.trigger(_self.vars.map, "resize");
			    _self.vars.map.setCenter(center);
			});

			// Update location and zoom values based on input field's value
			$(_self.vars.cssID + ".gllpUpdateButton").bind("click", function() {
				// var lat = $(_self.vars.cssID + ".gllpLatitude").val();
				// var lng = $(_self.vars.cssID + ".gllpLongitude").val();
				if($(_self.vars.cssID + ".gllpLatLong").val().indexOf(',') <= 0)
				{	
					return;
				}
				var lat = $(_self.vars.cssID + ".gllpLatLong").val().split(',')[0];
				var lng = $(_self.vars.cssID + ".gllpLatLong").val().split(',')[1];
				
				var latlng = new google.maps.LatLng(lat, lng);
				_self.vars.map.setZoom( parseInt( $(_self.vars.cssID + ".gllpZoom").val() ) );
				setPosition(latlng);
			});

			// Search function by search button
			$(_self.vars.cssID + ".gllpSearchButton").bind("click", function() {
				performSearch( $(_self.vars.cssID + ".gllpSearchField").val(), false );
			});

			// Search function by gllp_perform_search listener
			$(document).bind("gllp_perform_search", function(event, object) {
				performSearch( $(object).attr('string'), true );
			});

		    
			var autocomplete;

		    // Create the autocomplete object, restricting the search to geographical
		    // location types.
			autocomplete = new google.maps.places.Autocomplete(
                document.getElementById($(_self.vars.cssID + ".gllpSearchField").attr("id")));
			autocomplete.bindTo('bounds', _self.vars.map);
		    // When the user selects an address from the dropdown, populate the address
		    // fields in the form.
			autocomplete.addListener('place_changed', function () {
			    // performSearch($(_self.vars.cssID + ".gllpSearchField").val(), false);
			    var place = autocomplete.getPlace();
			    if (!place.geometry) {
			        window.alert("Cannot find location or not selected from list!");
			        return;
			    }

			    // If the place has a geometry, then present it on a map.
			    if (place.geometry.viewport) {
			        _self.vars.map.fitBounds(place.geometry.viewport);
			    } else {
			        _self.vars.map.setCenter(place.geometry.location);
			        _self.vars.map.setZoom(17);  // Why 17? Because it looks good.
			    }
			    
			    _self.vars.marker.setPosition(place.geometry.location);
			    _self.vars.marker.setVisible(true);
			    
			    setPosition(place.geometry.location);
			});

			

			// Zoom function triggered by gllp_perform_zoom listener
			$(document).bind("gllp_update_fields", function(event) {
				var lat = $(_self.vars.cssID + ".gllpLatitude").val();
				var lng = $(_self.vars.cssID + ".gllpLongitude").val();
				var latlng = new google.maps.LatLng(lat, lng);
				_self.vars.map.setZoom( parseInt( $(_self.vars.cssID + ".gllpZoom").val() ) );
				setPosition(latlng);
			});
			return _self.vars.map;
		}

	}

	return publicfunc;
});

}(jQuery));
/*
$(document).ready( function() {
	$(".gllpLatlonPicker").each(function() {
		$(document).gMapsLatLonPicker().init( $(this) );
		updateLatLng($(this));
       
	});
   
       
});
*/
function updateLatLng(object) {
    var lat = $(object).find('.gllpLatitude').val();
    var lng = $(object).find('.gllpLongitude').val();
    var latLng = lat + ',' + lng;
    $(object).find('.gllpLatLong').val(latLng);
}
$(document).bind("location_changed", function(event, object) {
    updateLatLng($(this));
});

var popupMap;
var curLat, curLng, curFormatAddress, curDeliveryAddress, curPostCode;
curLat = 20;
curLng = 20;
curFormatAddress = '';
curDeliveryAddress = '';
function AutocompleteFNC()
{
    if (individualpostcodeschecking == true)
        return false;
    var autocompletemain;
    //// Location Restriction Start
    /*var options = {
        types: ['(regions)'],
        componentRestrictions: { country: "gb" }
    };

    autocompletemain = new google.maps.places.Autocomplete(
        document.getElementById("validate_pc"), options);*/
    ///// //// Location Restriction End

    autocompletemain = new google.maps.places.Autocomplete(
        document.getElementById("validate_pc"));


    autocompletemain.addListener('place_changed', function () {
        var place = autocompletemain.getPlace();
        if (!place.geometry) {
            if (place.name == "") {
                window.alert("Cannot find location or not selected from list!");
            }
            return;
        }

        var tempStreetNumber1 = '', tempRouteName1 = '', tempLocalcity1 = '';
        
        for (i = 0; i < place.address_components.length; i++) {
            if (place.address_components[i].types[0] == "postal_code") {
                $("#hidPostCode").val(place.address_components[i].short_name);
            }
            else if (place.address_components[i].types[0] == "street_number") {
                tempStreetNumber1 = place.address_components[i].short_name + ' ';
            }
            else if (place.address_components[i].types[0] == "route") {
                tempRouteName1 = place.address_components[i].short_name;
            }
            else if (place.address_components[i].types[0] == "locality") {
                tempLocalcity1 = place.address_components[i].short_name;
            }
        }

        if (tempRouteName1 != '') {
            if (tempStreetNumber1 != '')
                $("#hidFormattedAdd").val(tempStreetNumber1 + '[*]' + tempRouteName1 + '[*]' + tempLocalcity1);
            else
                $("#hidFormattedAdd").val(tempRouteName1 + '[*]' + tempLocalcity1);
        }
        else $("#hidFormattedAdd").val(tempLocalcity1);

        $("#hidLat").val(place.geometry.location.lat());
        $("#hidLng").val(place.geometry.location.lng());

    });



    $(".fancybox")
    .fancybox({
        type: 'inline',
        //'scrolling': 'no',
        autoSize: false,
        height: "100%",
        width: "100%",
        closeBtn: false,
        fitToView: false,
        margin: [0, 0, 0, 0],
        afterShow: function () {
            /*if (popupMap == null) {
                popupMap = $(document).gMapsLatLonPicker().init($("#gllpLatlonPicker1"));
                updateLatLng($("#gllpLatlonPicker1"));

            }*/
            // google.maps.event.trigger(popupMap, "resize");     
            console.log("fancy box show");
          
               // $("#modalDivOrderTypeBody").modal("hide");
            $('#modalDivOrderType').modal("hide");
        },
        beforeShow: function () {
            if (popupMap == null) {
                popupMap = $(document).gMapsLatLonPicker().init($("#gllpLatlonPicker1"));
                updateLatLng($("#gllpLatlonPicker1"));

            }
            $(".gllpMap").css("padding-bottom", ((screen.height * 0.4) / screen.width) * 100 + "%");
        }
        , beforeClose: function () {
            $('#modalDivOrderType').modal("show");
        }
    });


    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function (position) {
            curLat = position.coords.latitude;
            curLng = position.coords.longitude;
            $("#aUseCurrentLoc").css("display", "");
            $("#aUseCurrentLoc").css("font-size", "12px");
            $("#aUseCurrentLoc").css("float", "left");

            $("#fancyBoxMap").css("display", "");
            $("#fancyBoxMap").css("font-size", "12px");
            $("#fancyBoxMap").css("float", "right");
            var latlng = new google.maps.LatLng(curLat, curLng);
            var geocoder = new google.maps.Geocoder();
            geocoder.geocode({ 'latLng': latlng }, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK && results[0]) {


                    curFormatAddress = results[0].formatted_address;
                    var tempStreetNumber = '', tempRouteName = '', tempLocalcity = '';
                    for (i = 0; i < results[0].address_components.length; i++) {
                        if (results[0].address_components[i].types[0] == "postal_code") {
                            curPostCode = results[0].address_components[i].short_name;
                        }
                        else if (results[0].address_components[i].types[0] == "street_number") {
                            tempStreetNumber = results[0].address_components[i].short_name + ' ';
                        }
                        else if (results[0].address_components[i].types[0] == "route") {
                            tempRouteName = results[0].address_components[i].short_name;
                        }
                        else if (results[0].address_components[i].types[0] == "locality") {
                            tempLocalcity = results[0].address_components[i].short_name;
                        }
                        else if (results[0].address_components[i].types[0] == "postal_town") {
                            tempLocalcity = results[0].address_components[i].short_name;
                        }
                    }
                    if (tempRouteName != '') {
                        curDeliveryAddress = tempStreetNumber + tempRouteName + ', ' + tempLocalcity;
                    }
                    else curDeliveryAddress = tempLocalcity;
                }
            });
            $("#aUseCurrentLoc").click(function () {


                $("#hidPostCode").val(curPostCode);
                $("#hidFormattedAdd").val(curDeliveryAddress);
                $("#hidLat").val(curLat);
                $("#hidLng").val(curLng);
                isSetLatLng = true;
                $("#validate_pc").val(curFormatAddress);
                return false;
            });

        }, function (err) {
            // if(err.code == 1)
            //    alert("We are unable to detect your location because your browser or device is currently not sharing your location with us.");
        });
    }
}
$(document).ready(function () {
    AutocompleteFNC();
   
});
function CloseMap(isSave) {
    if (isSave) {
        
        $("#hidLat").val($('#divFancyMap .gllpLatitude').val());
        $("#hidLng").val($('#divFancyMap .gllpLongitude').val());
        isSetLatLng = true;
        //$("#validate_pc").val($('#divFancyMap .gllpLatitude').val() + "," + $('#divFancyMap .gllpLongitude').val());
        if ($("#hidFormattedAdd").val().indexOf("[*]") > 0) {
            var arrHidAdd = $("#hidFormattedAdd").val().split("[*]");
            if(arrHidAdd.length == 3)
                $("#validate_pc").val(arrHidAdd[0] + " " + arrHidAdd[1] + ", " + arrHidAdd[2]);
            else
                $("#validate_pc").val(arrHidAdd[1] + ", " + arrHidAdd[2]);
        }
        else
            $("#validate_pc").val($("#hidFormattedAdd").val());
        //$("#updateFullPostcodeSubmit").tooltip({ trigger: 'manual' }).tooltip('show');
       // $("#validate_pc").trigger("keydown");

        
    }
    $.fancybox.close();
    // update issue 159
    if($.trim($("#modalDivOrderTypeBody").html())=="")
        $('#modalDivOrderType').modal("hide");
    // End 
   
}