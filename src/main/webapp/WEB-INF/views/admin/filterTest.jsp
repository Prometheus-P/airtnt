<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<html>
<head>
<link rel="stylesheet" type="text/css" href="resources/css/ui.jqgrid.css">
<link rel="stylesheet" type="text/css" href="resources/css/ui.jqgrid-bootstrap.css">

<script src='<c:url value='/resources/js/jquery-1.11.0.min.js'/>'/></script> 
<script src='<c:url value='/resources/js/jquery.jqGrid.min.js'/>'/></script>
<script src='<c:url value='/resources/js/i18n/grid.locale-kr.js'/>'/></script>

</head>
<body>
  <script type="text/javascript">

        $(function(){
            // 변수 선언
            var i, max, myData, grid = $("#list4");

            // grid 설정
            grid.jqGrid({
                datatype: "local",
                height: 'auto',
                colNames:['대분류코드','대분류명'],
                colModel:[
                    {name:'id',index:'id', width:200, sorttype:"int", },
                    {name:'propertyName',index:'propertyName', width:150},
                ],

                multiselect: true,
                caption: "숙소 필터 대분류"

            });



            // 로컬 데이터

            myData = [

                {id:"1",invdate:"2007-10-01",name:"test",note:"note",amount:"200.00",tax:"10.00",total:"210.00"},

                {id:"2",invdate:"2007-10-02",name:"test2",note:"note2",amount:"300.00",tax:"20.00",total:"320.00"},

                {id:"3",invdate:"2007-09-01",name:"test3",note:"note3",amount:"400.00",tax:"30.00",total:"430.00"},

                {id:"4",invdate:"2007-10-04",name:"test",note:"note",amount:"200.00",tax:"10.00",total:"210.00"},

                {id:"5",invdate:"2007-10-05",name:"test2",note:"note2",amount:"300.00",tax:"20.00",total:"320.00"},

                {id:"6",invdate:"2007-09-06",name:"test3",note:"note3",amount:"400.00",tax:"30.00",total:"430.00"},

                {id:"7",invdate:"2007-10-04",name:"test",note:"note",amount:"200.00",tax:"10.00",total:"210.00"},

                {id:"8",invdate:"2007-10-03",name:"test2",note:"note2",amount:"300.00",tax:"20.00",total:"320.00"},

                {id:"9",invdate:"2007-09-01",name:"test3",note:"note3",amount:"400.00",tax:"30.00",total:"430.00"}

            ];



            // 데이터 추가

            for( i=0, max = myData.length ; i<=max ; i++ ){

                grid.jqGrid('addRowData', i+1, myData[i]);

            }

        });

    </script>

</head>

<body>

<table id="list4"></table>

</body>

 

</html>
