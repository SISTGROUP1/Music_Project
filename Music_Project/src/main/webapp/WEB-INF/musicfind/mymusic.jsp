<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://unpkg.com/vue@3"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<style type="text/css">
	#other .song{
		font-weight: bold;
		color:black;
	}
	#other .artist{
		font-size:10px;
		color:gray;
	}
	#current .song{
		font-weight: bold;
		color:rgb(0, 185, 142);
	}
	#current .artist{
		font-size:10px;
		color:gray;
	}
	#current:hover{
		cursor: pointer;
	}
	#other:hover{
		cursor: pointer;
	}
</style>
</head>
<body>
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal" var="principal"/>
	</sec:authorize>
	<div class="container-xxl bg-white p-0">
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
		<div class="container-fluid header bg-white p-0" id="myMusicApp">
			<div class="row g-0 align-items-center flex-column-reverse flex-md-row">
				<div class="col-md-12 p-5 mt-lg-5">
					<h1 class="display-5 animated fadeIn mb-4"><span class="text-primary">내 음악</span> 리스트</h1>
					<div style="text-align: right;margin-right: 5%;">
						<input type="button" value="삭제" style="background-color: #00B98E;color:white;border:2px solid #00B98E;border-radius: 5px;" @click="DeleteMyList()">
					</div>
				</div>
				<div style="width:100%;height:100%">
					<div class="col-md-5 p-5" style="position: relative;overflow: hidden;float: left;width: 460px;height: 100%;">
						<div style="position: absolute;top: 0;left: 0;width: 100%;height: 100%;background-color: #3f4047;">
							<div style="border:1px solid black;height:100%;;background-repeat: repeat no-repeat;background-size: 100% 100%;filter:blur(20px);" :style="{'background-image':'url('+main_image+')'}">
							</div>
						</div>
						<div class="text-center" style="position: relative;min-height: 100%;padding: 63px 0 60px;color: #fff;-webkit-box-sizing: border-box;-moz-box-sizing: border-box;box-sizing: border-box;">
							<div style="display: block;padding: 4px 0;font-size: 17px;line-height: 1.5;font-weight: bold;">
								{{main_song}}
							</div>
							<div style="display: block;padding: 4px 0;font-size: 17px;line-height: 1.5;">
								{{main_artist}}
							</div>
							<img :src="main_image" style="vertical-align: middle;">
						</div>
					</div>
					<div class="col-md-7" style="position: relative;overflow: hidden;float: left;height: 400px;box-sizing: border-box;overflow-y:scroll;">
						<div>
							<table class="table">
								<tr v-for="(vo,index) in myMusic_data">
									<td class="text-center" width="5%" style="vertical-align: middle;">
										<input type="checkbox" :value="vo.vo.num" v-model="checked" @change="ss()">
									</td>
									<td width="95%" @click="ChangeImage(vo)" :id="vo.vo.num==main_num?'current':'other'">
										<span class="song">{{vo.song}}</span>
										<br>
										<span class="artist">{{vo.artist}}</span>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		let myMusicApp = Vue.createApp({
			data(){
				return{
					user_id:'${principal.username}',
					myMusic_data:{},
					main_image:'',
					main_song:'',
					main_artist:'',
					main_num:'',
					checked:[]
				}
			},
			mounted(){
				this.data_recv();
			},
			methods:{
				data_recv(){
					if(this.user_id==='' || this.user_id===null){
						if(confirm("로그인이 필요합니다.\n로그인 하시겠습니까?")){
							location.href="../member/sclogin.do";
						}
						else{
							location.href="../main/main.do";
						}
					}
					else{
						axios.get('../musicfind/MyMusicList_vue.do',{
							params:{
								userId:this.user_id
							}
						}).then(res=>{
							this.myMusic_data = res.data
							if(this.main_num===''){
								this.main_image = res.data[0].image
								this.main_song = res.data[0].song
								this.main_artist = res.data[0].artist
								this.main_num = res.data[0].vo.num
							}
						})
					}
				},
				ChangeImage(vo){
					this.main_image = vo.image
					this.main_song = vo.song
					this.main_artist = vo.artist
					this.main_num = vo.vo.num
					
					this.data_recv()
				},
				ss(){
				},
				DeleteMyList(){
					
					if(this.checked.length===0){
						alert("삭제할 목록을 선택해주세요.")
					}
					else{
					
						axios.get('../musicfind/MyMusicDelete_vue.do',{
							params:{
								checkedLst:this.checked.toString()
							}
						}).then(res=>{
							this.data_recv()	
						})
					}
				}
			}
		}).mount('#myMusicApp')
	</script>
</body>
</html>