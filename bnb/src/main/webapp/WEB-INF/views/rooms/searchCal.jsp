<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<script
	src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/jquery-ui.min.js"></script>
<link rel="stylesheet"
	href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" />

<style>
#ui-datepicker-div .ui-state-default {
	text-align: center !important;
	border: 0px solid #c5c5c5 !important;
	background: #ffffff !important;
	color: #454545 !important;
}

.ui-widget-header {
	border: 0px solid #dddddd !important;
	background: #ffffff !important;
}
/* placeholder color */
input:-ms-input-placeholder {
	color: #000;
}

input::-webkit-input-placeholder {
	color: #000;
}

input::-moz-placeholder {
	color: #000;
}

input::-moz-placeholder {
	color: #000;
}

#ui-datepicker-div {
	z-index: 1000 !important;
}
/* calendar table */
.ui-datepicker {
	display: none;
	background-color: #fff !important;
	border-radius: 5px !important;
	margin-top: 10px !important;
	margin-left: 42.5px !important;
	margin-right: 42.5px !important;
	padding: 20px !important;
	width: 360px !important;
}

.ui-datepicker-prev, .ui-datepicker-next {
	cursor: pointer !important;
}

.ui-datepicker-next {
	float: right !important;
}

.ui-state-disabled {
	cursor: auto !important;
	color: hsla(0, 0%, 80%, 1) !important;
}

.ui-datepicker-title {
	text-align: center !important;
	padding: 10px !important;
	font-weight: 100 !important;
	font-size: 20px !important;
}

.ui-datepicker-calendar {
	width: 100% !important;
}

/* day of week cell */
.ui-datepicker-calendar>thead>tr>th {
	padding: 5px !important;
	font-size: 20px !important;
	font-weight: 400 !important;
}

/* day cell */
.ui-datepicker-calendar>tbody>tr>td {
	border-radius: 100% !important;
	width: 44px !important;
	height: 44px !important;
	cursor: pointer !important;
	padding: 5px !important;
	font-weight: 100 !important;
	text-align: center !important;
}

.ui-datepicker-calendar>tbody>tr>td:hover {
	background-color: #c6e2f7 !important;
}

.ui-datepicker-calendar>tbody>tr>td>a {
	color: #000 !important;
	font-size: 18px !important;
	font-weight: 400 !important;
	text-decoration: none !important;
}


/* past days */
.ui-datepicker-calendar>tbody>tr>.ui-state-disabled:hover {
	cursor: auto !important;
	background-color: #fff !important;
}

/* media */
@media ( max-width : 445px) {
	.wrapper {
		width: calc(100vw - 20px) !important;
	}
	.ui-datepicker {
		margin-right: 0 !important;
		margin-left: 0 !important;
		padding: 10px !important;
		width: calc(100vw - 20px) !important;
		margin: 10px auto !important;
	}
	.ui-datepicker-calendar>tbody>tr>td {
		width: 38px !important;
		height: 38px !important;
	}
}
</style>
</head>

<body>
	<div class="wrapper">
		<div>
			<input type="text" id="checkIn" name="checkIn" placeholder="체크인"
				readonly="readonly" class="form-control text-center mt-1" />
		</div>
		<div>
			<input type="text" id="checkOut" name="checkOut" placeholder="체크아웃"
				readonly="readonly" class="form-control text-center mt-1" />
		</div>
	</div>

	<script>
		$.datepicker.setDefaults({
			closeText : "닫기",
			prevText : "이전달",
			nextText : "다음달",
			currentText : "오늘",
			monthNames : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월",
					"9월", "10월", "11월", "12월" ],
			monthNamesShort : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월",
					"9월", "10월", "11월", "12월" ],
			dayNames : [ "일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일" ],
			dayNamesShort : [ "일", "월", "화", "수", "목", "금", "토" ],
			dayNamesMin : [ "일", "월", "화", "수", "목", "금", "토" ],
			weekHeader : "주",
			dateFormat : "yy-m-d",
			firstDay : 0,
			isRTL : false,
			showMonthAfterYear : true,
			yearSuffix : "년"
		})
		$("#checkIn").datepicker(
				{
					minDate : 0,
					/* to use in wix */
					onSelect : function(selected, event) {
						searchRoomsList();
						/* 
						 * wix-send-messages from html component
						 * https://support.wix.com/en/article/working-with-the-html-component-in-wix-code
						 */
						window.parent.postMessage(selected, "*");

					},
					onClose : function(selected) {
						var year = Number(selected.substring(0, 4));
						var month = Number(selected.substring(5, 7)) - 1;
						var date = Number(selected.substring(8, 10)) + 1;

						$("#checkOut").datepicker("option",
								"minDate", new Date(year, month, date));
					}
				})

		$("#checkOut").datepicker({
			minDate : 0,
			onSelect : function(selected, event) {
				searchRoomsList();
				window.parent.postMessage(selected, "*");
			},
		});
	</script>
</body>

</html>