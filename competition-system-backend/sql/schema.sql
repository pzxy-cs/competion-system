-- 技能大赛训练系统数据库结构设计
-- 默认使用 InnoDB 引擎与 utf8mb4 字符集
-- 所有表均包含：created_on, updated_on, deleted_on, creator, updater 字段

-- 1. 角色表
CREATE TABLE IF NOT EXISTS roles (
    id            BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键',
    name          VARCHAR(64)  NOT NULL COMMENT '角色名称',
    description   VARCHAR(255)          COMMENT '角色描述',
    created_on    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_on    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted_on    DATETIME               DEFAULT NULL COMMENT '删除时间',
    creator       VARCHAR(64)            COMMENT '创建人',
    updater       VARCHAR(64)            COMMENT '更新人'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统角色';

-- 2. 权限表
CREATE TABLE IF NOT EXISTS permissions (
    id            BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键',
    code          VARCHAR(64)  NOT NULL UNIQUE COMMENT '权限编码',
    description   VARCHAR(255)          COMMENT '权限描述',
    created_on    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_on    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted_on    DATETIME               DEFAULT NULL COMMENT '删除时间',
    creator       VARCHAR(64)            COMMENT '创建人',
    updater       VARCHAR(64)            COMMENT '更新人'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统权限';

-- 3. 角色-权限关联表
CREATE TABLE IF NOT EXISTS role_permission_rel (
    role_id       BIGINT NOT NULL COMMENT '角色ID',
    permission_id BIGINT NOT NULL COMMENT '权限ID',
    PRIMARY KEY (role_id, permission_id),
    FOREIGN KEY (role_id) REFERENCES roles(id),
    FOREIGN KEY (permission_id) REFERENCES permissions(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色与权限关系';

-- 4. 用户表
CREATE TABLE IF NOT EXISTS users (
    id            BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键',
    username      VARCHAR(64)  NOT NULL UNIQUE COMMENT '用户名/学号',
    password_hash VARCHAR(255) NOT NULL COMMENT '密码哈希',
    real_name     VARCHAR(64)           COMMENT '真实姓名',
    email         VARCHAR(128)          COMMENT '邮箱',
    phone         VARCHAR(32)           COMMENT '电话',
    role_id       BIGINT       NOT NULL COMMENT '角色ID',
    status        TINYINT      NOT NULL DEFAULT 1 COMMENT '状态(1=正常,0=禁用)',
    created_on    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_on    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted_on    DATETIME               DEFAULT NULL COMMENT '删除时间',
    creator       VARCHAR(64)            COMMENT '创建人',
    updater       VARCHAR(64)            COMMENT '更新人',
    FOREIGN KEY (role_id) REFERENCES roles(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统用户';

-- 5. 操作日志表
CREATE TABLE IF NOT EXISTS operation_logs (
    id            BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键',
    user_id       BIGINT       NOT NULL COMMENT '用户ID',
    action        VARCHAR(128) NOT NULL COMMENT '操作动作',
    description   TEXT                  COMMENT '操作描述',
    ip_address    VARCHAR(45)           COMMENT 'IP地址',
    created_on    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_on    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted_on    DATETIME               DEFAULT NULL COMMENT '删除时间',
    creator       VARCHAR(64)            COMMENT '创建人',
    updater       VARCHAR(64)            COMMENT '更新人',
    FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户操作日志';

-- 6. 消息通知表
CREATE TABLE IF NOT EXISTS messages (
    id            BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键',
    receiver_id   BIGINT       NOT NULL COMMENT '接收用户ID',
    type          VARCHAR(32)  NOT NULL COMMENT '消息类型',
    title         VARCHAR(128) NOT NULL COMMENT '标题',
    content       TEXT                  COMMENT '内容',
    is_read       TINYINT      NOT NULL DEFAULT 0 COMMENT '是否已读',
    send_time     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发送时间',
    created_on    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_on    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted_on    DATETIME               DEFAULT NULL COMMENT '删除时间',
    creator       VARCHAR(64)            COMMENT '创建人',
    updater       VARCHAR(64)            COMMENT '更新人',
    FOREIGN KEY (receiver_id) REFERENCES users(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统消息通知';

-- 7. 竞赛表
CREATE TABLE IF NOT EXISTS competitions (
    id            BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键',
    name          VARCHAR(128) NOT NULL COMMENT '竞赛名称',
    category      VARCHAR(64)           COMMENT '类别',
    description   TEXT                  COMMENT '竞赛描述',
    start_time    DATETIME              COMMENT '开始时间',
    end_time      DATETIME              COMMENT '结束时间',
    status        TINYINT      NOT NULL DEFAULT 0 COMMENT '状态(0=未开始,1=进行中,2=已结束)',
    created_on    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_on    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted_on    DATETIME               DEFAULT NULL COMMENT '删除时间',
    creator       VARCHAR(64)            COMMENT '创建人',
    updater       VARCHAR(64)            COMMENT '更新人'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='竞赛信息';

-- 8. 竞赛试题表
CREATE TABLE IF NOT EXISTS competition_problems (
    id            BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键',
    competition_id BIGINT      NOT NULL COMMENT '竞赛ID',
    title         VARCHAR(128) NOT NULL COMMENT '题目标题',
    description   TEXT                  COMMENT '题目描述',
    reference_video_url VARCHAR(255)    COMMENT '参考视频地址',
    max_score     INT          NOT NULL DEFAULT 100 COMMENT '满分',
    created_on    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_on    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted_on    DATETIME               DEFAULT NULL COMMENT '删除时间',
    creator       VARCHAR(64)            COMMENT '创建人',
    updater       VARCHAR(64)            COMMENT '更新人',
    FOREIGN KEY (competition_id) REFERENCES competitions(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='竞赛试题';

-- 9. 竞赛提交表
CREATE TABLE IF NOT EXISTS competition_submissions (
    id            BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键',
    competition_id BIGINT      NOT NULL COMMENT '竞赛ID',
    problem_id    BIGINT       NOT NULL COMMENT '试题ID',
    user_id       BIGINT       NOT NULL COMMENT '参赛用户ID',
    answer        TEXT                  COMMENT '提交内容',
    score         INT                   COMMENT '得分',
    feedback      TEXT                  COMMENT '评语/反馈',
    submitted_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '提交时间',
    created_on    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_on    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted_on    DATETIME               DEFAULT NULL COMMENT '删除时间',
    creator       VARCHAR(64)            COMMENT '创建人',
    updater       VARCHAR(64)            COMMENT '更新人',
    FOREIGN KEY (competition_id) REFERENCES competitions(id),
    FOREIGN KEY (problem_id)    REFERENCES competition_problems(id),
    FOREIGN KEY (user_id)       REFERENCES users(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='竞赛提交记录';

-- 10. 系统设置表
CREATE TABLE IF NOT EXISTS system_settings (
    id            BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键',
    `key`         VARCHAR(64)  NOT NULL UNIQUE COMMENT '配置键',
    `value`       VARCHAR(255) NOT NULL COMMENT '配置值',
    description   VARCHAR(255)          COMMENT '描述',
    created_on    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_on    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted_on    DATETIME               DEFAULT NULL COMMENT '删除时间',
    creator       VARCHAR(64)            COMMENT '创建人',
    updater       VARCHAR(64)            COMMENT '更新人'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统设置';
