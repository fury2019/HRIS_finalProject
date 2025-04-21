package kr.or.ddit.file.vo;

import java.util.List;

import lombok.Data;

/**
 * 
 * @author CHOI
 * @since 2025. 3. 12.
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      			수정자           수정내용
 *  -----------   	-------------    ---------------------------
 *  2025. 3. 12.     	CHOI	         파일 관련 
 *
 * </pre>
 */
@Data
public class FileVO {
	private Long fileId; // 파일 고유 식별자
	private String fileDel; // 파일 삭제 여부 
	private List<FileDetailVO> fileDetails; // 파일 상세 -> 1 : 다 
}
