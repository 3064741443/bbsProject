var xmlHttp;
function createXMLHttpRequest() {
	if (window.XMLHttpRequest) {
		xmlHttp = new XMLHttpRequest();
	} else if (window.ActiveXObject) {
		xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
}

function doAjax(queryString, handleStateChange, url) {
	createXMLHttpRequest(); // 创建了xmlhttprequest对象
	xmlHttp.onreadystatechange = handleStateChange;// 绑定回调函数（当服务器有回传结果时，由浏览器自动调用的函数）
	xmlHttp.open("post", url, true);
	xmlHttp.setRequestHeader("Content-Type",
			"application/x-www-form-urlencoded"); // 传递参数的编码方式
	xmlHttp.send(queryString); // 发送请求
}