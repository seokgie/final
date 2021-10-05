package com.gudi.main.util;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;

@Component
public class UploadUtil {
    public static String root;

    @Value("#{uploadPath['commons.filePath']}")
    public void setRoot(String value) {
        root = value;
    }

    /**
     * 파일 업로드 메서드
     * HashMap 안에 oriFileName,newFileName 들어있음 꺼내쓰셈
     * 작성자: 박한솔
     *
     * @param file MultipartFile
     * @return 전송 결과 값 HashMap<String,String>
     */
    public static HashMap<String, String> fileUpload(MultipartFile file) {
        HashMap<String, String> map = new HashMap<String, String>();
        //1.파일명 추출
        String oriFileName = file.getOriginalFilename();
        //2.신규파일명
        String newFileName = System.nanoTime() + oriFileName.substring(oriFileName.lastIndexOf('.'));
        //3.파일 다운로드
        try {
            byte[] bytes = file.getBytes();
            // 이 저장 방법은 자바 7부터 가능(java.nio)
            
            //폴더생성 추가!
        	File Folder = new File(root);
        	// 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
        	if (!Folder.exists()) {
        		try{
        		    Folder.mkdir(); //폴더 생성합니다.
        		    System.out.println("폴더가 생성되었습니다.");
        	        } 
        	        catch(Exception e){
        		    e.getStackTrace();
        		}        
                 }else {
        		System.out.println("이미 폴더가 생성되어 있습니다.");
        	}
        	//폴더생성 추가 끝!
            
            Path filePath = Paths.get(root + newFileName); //경로 지정
            Files.write(filePath, bytes); //저장               
            map.put("oriFileName", oriFileName);
            map.put("newFileName", newFileName);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    /**
     * 파일 삭제 메서드
     * newFileName 넣으셈 알아서 삭제됨 삭제되면 true 아니면 false
     *
     * 작성자: 박한솔
     * @param newFileName String
     * @return 전송 결과 값 boolean
     */
    public static boolean fileDelete(String newFileName) {
        boolean suc = false;
        
        File delFile = new File(root + newFileName);
        if (delFile.exists()) {
            suc = delFile.delete();
        }
        
        return suc;
    }

    /**
     * 파일 다운로드 메서드
     * 걍 컨트롤러에서 void 형태로 얘 부르셈 그럼 끝임
     * 작성자: 박한솔
     *
     * @param oriFileName String
     * @param newFileName String
     * @param response HttpServletResponse
     */
    public static void fileDownload(String oriFileName, String newFileName, HttpServletResponse response) {
        try {
            // 1. C:/upload 에 있는 파일 읽어오기
            Path path = Paths.get(root + newFileName);
            byte[] bytes = Files.readAllBytes(path);
            // 2. response 객체 설정하기
            response.setContentType("application/octet-stream");
            oriFileName = URLEncoder.encode(oriFileName, "UTF-8"); //파일명 한글깨짐 방지
            response.setHeader("content-Disposition", "attachment;fileName=\"" + oriFileName + "\"");// "img.png"
            // 3. response 객체에 파일 넣기
            BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
            bos.write(bytes);
            // 4. 종료
            bos.flush();
            bos.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
