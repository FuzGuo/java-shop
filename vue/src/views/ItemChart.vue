<template>
  <div style="display: flex; justify-content: space-around;">
    <div ref="chart" style="width: 600px;height:600px;"></div>
    <div ref="barChart" style="width: 600px; height: 500px;"></div>
  </div>
</template>

<script>
import request from "../../utils/request";
import { UploadFilled } from '@element-plus/icons'
import * as echarts from 'echarts';

export default {
  name: 'storage' ,
  components:{
    UploadFilled,
  },

  data() {
    return {
      dialogFormVisible:false,
      form:{},
      currentPage :1,
      tableData: [
      ],
      tableData2: [
        { name: '商品A', salesVolume: 120 },
        { name: '商品B', salesVolume: 150 },
        { name: '商品C', salesVolume: 80 },
        { name: '商品D', salesVolume: 200 },
        { name: '商品E', salesVolume: 170 },
        { name: '商品F', salesVolume: 110 },
        { name: '商品G', salesVolume: 90 }
      ],
      search: '',
      total:10,
      dialogImageUrl: '',
      user:{},
      filesUploadUrl: "http://"+window.server.filesUploadUrl+":9090/files/upload"
    }
  },mounted() {
    this.createChart();
  },
  created() {
    let str = sessionStorage.getItem("user")
    this.user = JSON.parse(str)
    if(this.user.role===2){
      this.form.storeId=this.user.id
    }

    this.load()

  },
  methods: {

    filesUploadSuccess(res,file){
      console.log(res)
      this.form.cover=res.data
    },
    load(){
      if(this.user.role===3){
        request.get("/storage",{
          params:{
            pageNum: this.currentPage,
            pageSize: this.pageSize,
            search: this.search
          }
        }).then(res=>{
          console.log(res)
          this.tableData=res.data.records
          this.total=res.data.total
          this.createChart();
        })
      }else{
        request.get("/storage/getStore",{
          params:{
            pageNum: this.currentPage,
            pageSize: this.pageSize,
            search: this.search,
            id:this.user.id,
          }
        }).then(res=>{
          console.log(res)
          this.tableData=res.data.records
          this.total=res.data.total
          this.createChart();
        })
      }

    },
    add(){
      this.dialogFormVisible = true;
      this.form={};
      this.$refs['upload'].clearFiles()
    },
    save(){
      console.log(this.user)
      if(this.user.role===2){
        this.form.storeId=this.user.id
      }
      if(this.form.id){
        //update
        console.log(this.form)
        request.put("/storage",this.form).then(res =>{
          console.log(res)
          if(res.code==='0'){
            this.$message({
              type:"success",
              message:"更新成功"
            })
          }else {
            this.$message({
              type:"error",
              message:res.msg
            })
          }
          this.load()
          this.dialogFormVisible =false
        })
      }else{
        request.post("/storage",this.form).then(res =>{
          console.log(res)
          if(res.code==='0'){
            this.$message({
              type:"success",
              message:"新增成功"
            })
          }else {
            this.$message({
              type:"error",
              message:res.msg
            })
          }
          this.load()
          this.dialogFormVisible=false
        })
      }
    },

    handleEdit(row) {
      this.form=JSON.parse(JSON.stringify(row))
      this.dialogFormVisible=true
      this.$nextTick(()=>{
        this.$refs['upload'].clearFiles()
      })
    },
    handleDelete(id) {
      console.log(id)
      request.delete("/storage/"+id).then(res=>{
        if(res.code==='0'){
          this.$message({
            type:"success",
            message:"删除成功"
          })
        }else {
          this.$message({
            type: "error",
            message: res.msg
          })
        }
        this.load()
      })
    },
    handleSizeChange(pageSize){
      this.pageSize=pageSize
      this.load()
    },
    handleCurrentChange(pageNum){//改变页码
      this.currentPage=pageNum
      this.load()
    },
    createChart() {
      const chartDom = this.$refs.chart;
      const myChart = echarts.init(chartDom);
      const option = {
        title: {
          text: '商品销量分布',
          left: 'center'
        },
        tooltip: {
          trigger: 'item'
        },
        legend: {
          orient: 'vertical',
          left: 'left'
        },
        series: [
          {
            name: '销量',
            type: 'pie',
            radius: '50%',
            data: this.tableData.map(item => {
              return { value: item.salesVolume, name: item.name };
            }),
            emphasis: {
              itemStyle: {
                shadowBlur: 10,
                shadowOffsetX: 0,
                shadowColor: 'rgba(0, 0, 0, 0.5)'
              }
            }
          }
        ]
      };
      myChart.setOption(option);
      this.createBarChart()
    },
    createBarChart() {
      const barChartDom = this.$refs.barChart;
      const barChart = echarts.init(barChartDom);
      const barOption = {
        title: {
          text: '商品销量条形图',
          left: 'center'
        },
        tooltip: {
          trigger: 'axis',
          axisPointer: {
            type: 'shadow'
          }
        },
        xAxis: {
          type: 'category',
          data: this.tableData.map(item => item.name),
          axisLabel: {
            rotate: 45, // 旋转45度
            interval: 0 // 显示所有标签
          }
        },
        yAxis: {
          type: 'value'
        },
        series: [{
          name: '销量',
          data: this.tableData.map(item => item.salesVolume),
          type: 'bar',
          barWidth: '60%'
        }]
      };
      barChart.setOption(barOption);
    }
  },
}
</script>
