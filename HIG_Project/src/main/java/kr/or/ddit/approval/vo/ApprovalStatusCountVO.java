package kr.or.ddit.approval.vo;

import java.io.Serializable;

import lombok.Data;

/**
 * 
 * @author CHOI
 * @since 2025. 4. 11.
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      			수정자           수정내용
 *  -----------   	-------------    ---------------------------
 *  2025. 4. 11.     	CHOI	          연차 상태 건수 
 *
 * </pre>
 */
@Data
public class ApprovalStatusCountVO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String userStatus; // ex) 대기, 진행중, 승인중, 반려
	private int cnt; // 차트용 결재 관련 건수 
}
