from pydantic import BaseModel
from typing import Optional, List
from datetime import datetime

class QuizSessionCreate(BaseModel):
    user_id: int
    mode: str  # "training" ou "exam"
    difficulty_level: Optional[int] = None  # 1, 2, 3 ou None pour tous les niveaux

class QuizSessionOut(BaseModel):
    id: int
    user_id: int
    mode: str
    difficulty_level: Optional[int]
    is_active: bool
    score: Optional[float]
    total_answered: int
    correct_answers: int
    started_at: datetime
    paused_at: Optional[datetime] = None
    ended_at: Optional[datetime] = None

    class Config:
        orm_mode = True

class UserAnswerCreate(BaseModel):
    session_id: int
    question_id: int
    selected_choice_ids: List[int]  # ex: [1, 3, 4]
    user_id: int

class UserAnswerOut(BaseModel):
    id: int
    session_id: int
    question_id: int
    selected_choice_ids: List[int]
    is_correct: bool
    answered_at: datetime

    class Config:
        orm_mode = True
