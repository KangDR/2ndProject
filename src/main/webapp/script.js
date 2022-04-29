/**
 * 
 */
function writeSave(){
	if($("input[name='id']").val().length==0){
		alert("아이디가 누락되었습니다.");
		return false;
	}
	if($("input[name='password']").val().length==0){
		alert("비밀번호가 누락되었습니다.");
		return false;
	}
	if($("input[name='password2']").val().length==0){
		alert("비밀번호확인칸이 누락되었습니다.");
		return false;
	}
	if($("input[name='password']").val()!=$("input[name='password2']").val()){
		alert("비밀번호 확인하세요.");
		return false;
	}
	if($("input[name='name']").val().length==0){
		alert("이름이 누락되었습니다.");
		return false;
	}
	if($("input[name='email']").val().length==0){
		alert("이메일이 누락되었습니다.");
		return false;
	}
	if(isCheck==false){
		alert("중복체크하세요");
		return false;
	}
	if(use=="impossible"){
			alert("이미 사용중입니다.")
			return false;
	}
	
}
function duplicate(){
	$("input[name='id']").keydown(function(){
		$('#idcheck').css("display","none");
		use="";
		isCheck=false;
	})
	$.ajax({
		url:"idCheck.jsp",
		data:({
			id:$("input[name='id']").val()
		}),
		success:function(data){
			if($("input[name='id']").val().length==0){
				$('#idcheck').html("<font color=red>입력 누락.");
				$('#idcheck').show();
			}
			else if($.trim(data)=="NO"){
				$('#idcheck').html("<font color=green>사용 가능합니다.");
				use="possible";
				isCheck=true;
				$('#idcheck').show();
			}
			else if($.trim(data)=="YES"){
				$('#idcheck').html("<font color=red>사용 불가능합니다.");
				use="impossible";
				isCheck=true;
				$('#idcheck').show();
			}
		}
	})
}
function pwcheck(){
	var pw=$("input[name='password']").val();
	var regexp=/^[a-z0-9]{3,8}$/;
	if(pw.search(regexp)==-1){
		alert("비밀번호 형식 확인");
	}
	var chk_num =pw.search(/[0-9]/);
	var chk_eng =pw.search(/[a-z]/);
	if(chk_num<0||chk_eng<0){
		alert("비밀번호는 영문과 숫자를 조합");
	}
}
function repwcheck(){
	if($("input[name='password2']").val()==$("input[name='password']").val()){
	$('#pwmessage').html("<font color=green>비밀번호가 일치합니다.");
	}
	else{
	$('#pwmessage').html("<font color=red>비밀번호가 불일치합니다.");
	}
}
function searchList(){
		$.ajax({
			url:"topajax.jsp",
			data:({
				search:$("input[name='search']").val()
			}),
			success:function(data){
			array1=data.replace("[","");
			array2=array1.replace("]","");
			array=array2.split(",");
			str="";
			str+="<datalist id='listid'>";
			for(var i in array){
				str+="<option label='"+$.trim(array[i])+"' value='"+$.trim(array[i])+"'>";
				}
			str+="</datalist>";
			if($("input[name='search']").val()!=""){
				$("input[name='search']").html(str);
			}
			}
		})
}