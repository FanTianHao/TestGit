package com.ego.service.impl;

import com.ego.result.FileResult;
import com.ego.service.FileUploadServiceI;
import com.ego.util.DateUtil;

import com.ego.util.FTPUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;


import java.io.InputStream;
import java.time.LocalDateTime;

/**
 * Created by ASUS on 2019/5/16.
 */
@Service
public class FileUploadServiceImpl implements FileUploadServiceI{
    //对应ftp.properties中的参数
    //ftp服务器地址
    @Value("${ftp.host}")
    private String ftpHost;
    //ftp端口
    @Value("${ftp.port}")
    private Integer ftpPort;
    //ftp用户名
    @Value("${ftp.username}")
    private String ftpUsername;
    //ftp用户密码
    @Value("${ftp.password}")
    private String ftpPassword;
    //ftp服务器上传路径
    @Value("${ftp.path}")
    private String ftpPath;

    //文件上传
    @Override
    public FileResult fileUploadSave(String fileName, InputStream inputStream) {

        //得到日期格式
        String dateStr = DateUtil.getDateStr(LocalDateTime.now(),DateUtil.pattern_date);
        //得到文件上传至服务器的名称
        String newFtpPath=ftpPath+"/"+dateStr;
        String remoteName = FTPUtil.fileUpload(ftpHost,
                ftpPort,
                ftpUsername,
                ftpPassword,
                newFtpPath,
                fileName,
                inputStream);
        FileResult result = new FileResult();
        if(remoteName != null && remoteName.length()>0){
            //最终上传至服务器的文件全路径:http://192.168.159.24/2019/05/17/UUID.jpg
            String imageUrl = "http://" + ftpHost + "/" + dateStr + "/" + remoteName;
            result.setSuccess("success！");
            result.setFileUrl(imageUrl);
        }

        return result;
    }

    @Override
    public Boolean fileDelete(String fileName) {
        return FTPUtil.fileDelete(ftpHost, ftpPort,ftpUsername, ftpPassword,
                fileName, ftpPath);
    }
}
