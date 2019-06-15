package com.ego.util;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

/**
 * Created by ASUS on 2019/5/15.
 */
//上传文件至 ftp 服务器的工具类
public class FTPUtil {
    private static Logger logger = LoggerFactory.getLogger(FTPUtil.class);
    //上传文件至 ftp 服务器
    public static String fileUpload(String host,
                                    Integer port,
                                    String username,
                                    String password,
                                    String ftpPath,//上传路径
                                    String fileName,//上传文件的名字
                                    InputStream inputStream){
        //1.创建ftpClient对象
        FTPClient ftpClient = null;
        try {
            // 1、创建FTPClient对象
            ftpClient = new FTPClient();
            //保存FTP控制连接使用的字符集,必须在连接前设置
            ftpClient.setControlEncoding("UTF-8");
            //2.指定服务器地址
            ftpClient.connect(host,port);
            //3.指定用户名和密码
            ftpClient.login(username,password);
            //连接成功返回230表示成功,返回530则代表无密码或者用户名或者密码错误
            int replyCode = ftpClient.getReplyCode();
            System.out.println(replyCode);
            // 具体的搜索“FTP 上传常见错误详解
            //isPositiveCompletion()代表 reply >= 200 && reply < 300;
            if(!FTPReply.isPositiveCompletion(replyCode)){
                ftpClient.disconnect();//关闭连接
                return null;
            }

            //5.指定上传的路径.如果没有需要创建
            String temp = "";
            for(String p:ftpPath.split("/")){
                temp += (p + "/");
                // 判断目录是否已经存在
                boolean hasPath = ftpClient.changeWorkingDirectory(temp);
                if (!hasPath) {
                    // 创建目录 一次只能创建一个目录
                    ftpClient.makeDirectory(temp);
                }
            }
            // 重新选择上传路径
            ftpClient.changeWorkingDirectory(ftpPath);
            //6.指定上传方式为二进制方式
            ftpClient.setFileType(FTP.BINARY_FILE_TYPE);
            //得到文件后缀
            String suffix = fileName.substring(fileName.lastIndexOf("."));
            //7.remote 指定上传远程服务器的文件名 local指本地的输入流
            String remote = UUID.randomUUID().toString()+suffix;
            ftpClient.storeFile(remote,inputStream);
            return remote;
        } catch (IOException e) {
            logger.error("文件上传失败,失败原因:"+e.getMessage());
        } finally{
            try {
                if(null!=inputStream)
                    inputStream.close();

                if(null!=ftpClient && ftpClient.isConnected()){
                    ftpClient.logout();
                    ftpClient.disconnect();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return null;
    }
    /**
     * 文件删除成功与否返回一个 boolean
     *
     * @param host
     * @param port
     * @param username
     * @param password
     * @param pathName
     * @param path
     * @return
     */
    public static boolean fileDelete(String host, Integer port, String username, String password,
                                     String pathName, String path) {
        // 1、创建 FTPClient 对象
        FTPClient ftpClient = new FTPClient();
        // 保存 FTP 控制连接使用的字符集，必须在连接前设置
        ftpClient.setControlEncoding("UTF-8");
        // 删除成功与否返回值
        boolean result = false;
        try {
            // 2、指定服务器地址（端口）
            ftpClient.connect(host, port);
            // 3、指定用户名和密码
            ftpClient.login(username, password);
            // 连接成功或者失败返回的状态码
            int reply = ftpClient.getReplyCode();
            // 如果 reply 返回 230 表示成功，如果返回 530 表示无密码或用户名错误或密码错误或用户权限问题。
            System.out.println(reply);
            // 具体的搜索“FTP 上传常见错误详解”
            if (!FTPReply.isPositiveCompletion(reply)) {
                ftpClient.disconnect();
                logger.error("用户名或密码错误或用户权限问题！");
                return result;
            }
            String[] pathArray = pathName.split("/");
            // 拼接删除路径
            path += "/" + pathArray[3] + "/" + pathArray[4] + "/" + pathArray[5];
            String basePath = "/";
            for (String p : path.split("/")) {
                basePath += (p + "/");
                // 判断目录是否已经存在
                boolean hasPath = ftpClient.changeWorkingDirectory(basePath);
                if (!hasPath) {
                    logger.error("删除失败，目录不存在！");
                    return result;
                }
            }
            result = ftpClient.deleteFile(path + "/" + pathArray[6]);
            if (!result)
                logger.error("删除失败，文件不存在！");
        } catch (IOException e) {
            logger.error("删除失败：" + e.getMessage());
        } finally {
            try {
                ftpClient.logout();
                if (ftpClient.isConnected()) {
                    ftpClient.disconnect();
                }
            } catch (IOException e) {
                logger.error("删除失败：" + e.getMessage());
            }
        }
        return result;
    }

}
