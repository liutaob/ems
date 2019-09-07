package com.ems.bean;

import java.io.Serializable;
import java.util.Date;

public class EmsSalary implements Serializable {
    /**
     * 工资id，随机生成
     */
    private Long id;

    /**
     * 员工id
     */
    private Long empId;

    /**
     * 工资金额 同员工工资属性
     */
    private Long money;

    /**
     * 发放状态，1-已发放，2-未发放
     */
    private Integer status;

    /**
     * 发放时间
     */
    private Date created;

    /**
     * 更新时间
     */
    private Date updated;

    private static final long serialVersionUID = 1L;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getEmpId() {
        return empId;
    }

    public void setEmpId(Long empId) {
        this.empId = empId;
    }

    public Long getMoney() {
        return money;
    }

    public void setMoney(Long money) {
        this.money = money;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }

    public Date getUpdated() {
        return updated;
    }

    public void setUpdated(Date updated) {
        this.updated = updated;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", empId=").append(empId);
        sb.append(", money=").append(money);
        sb.append(", status=").append(status);
        sb.append(", created=").append(created);
        sb.append(", updated=").append(updated);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}