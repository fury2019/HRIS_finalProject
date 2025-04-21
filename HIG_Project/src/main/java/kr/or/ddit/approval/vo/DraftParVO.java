package kr.or.ddit.approval.vo;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import lombok.Data;


/**
 * 
 * @author CHOI
 * @since 2025. 3. 10.
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      			수정자           수정내용
 *  -----------   	-------------    ---------------------------
 *  2025. 3. 10.     	CHOI	         참조자 수신자
 *
 * </pre>
 */
@Data
public class DraftParVO implements Serializable{
	@NotNull
	private Long parId; // 참조자/수신자 ID(PK)
	@NotNull
	private Long draftId; // 기안관리ID
	@NotBlank
	private String empId; // 직원 정보를 저장하는 테이블
	@NotBlank
	private String role; // 참조자,수신자
	private String isRead; // 읽음여부(Y/N)
	private Date checkedAt; // 참조자/수신자가 확인한시간 
}
