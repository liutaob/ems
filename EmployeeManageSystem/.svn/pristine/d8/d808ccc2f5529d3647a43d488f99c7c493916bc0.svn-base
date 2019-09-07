package com.ems.bean;

import java.io.Serializable;
import java.util.Date;

public class EmsNotice implements Serializable {
    /**
     * 新闻公告id,随机生成
     */
    private Long id;

    /**
     * 新闻标题
     */
    private String noticeTitle;

    /**
     * 发布时间
     */
    private Date created;

    /**
     * 发布人ID
     */
    private Long empId;

    /**
     * 部门ID
     */
    private Long deptId;

    /**
     * 新闻内容
     */
    private String content;

    private static final long serialVersionUID = 1L;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNoticeTitle() {
        return noticeTitle;
    }

    public void setNoticeTitle(String noticeTitle) {
        this.noticeTitle = noticeTitle == null ? null : noticeTitle.trim();
    }

    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }

    public Long getEmpId() {
        return empId;
    }

    public void setEmpId(Long empId) {
        this.empId = empId;
    }

    public Long getDeptId() {
        return deptId;
    }

    public void setDeptId(Long deptId) {
        this.deptId = deptId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", noticeTitle=").append(noticeTitle);
        sb.append(", created=").append(created);
        sb.append(", empId=").append(empId);
        sb.append(", deptId=").append(deptId);
        sb.append(", content=").append(content);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}